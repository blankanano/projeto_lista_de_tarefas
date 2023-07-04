import '../routes/route_paths.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool isLoading = false;

  final picker = ImagePicker();
  PickedFile? _pickedImage;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    loadImageFromFirebaseStorage();
  }

  Future<void> loadImageFromFirebaseStorage() async {
    final user = auth.currentUser;
    if (user != null) {
      final storage = firebase_storage.FirebaseStorage.instance;
      final reference = storage.ref().child(
          'MinhasImagens/${user.uid}/my_image.jpg'); // Caminho da imagem no Firebase Storage

      try {
        final downloadUrl = await reference.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } catch (e) {
        print('Erro ao carregar a imagem do Firebase Storage: $e');
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);
    setState(() {
      _pickedImage = pickedImage;
    });

    if (_pickedImage != null) {
      final user = auth.currentUser;
      if (user != null) {
        final storage = firebase_storage.FirebaseStorage.instance;
        final reference = storage.ref().child(
            'MinhasImagens/${user.uid}/my_image.jpg'); // Caminho da imagem no Firebase Storage

        final file = File(_pickedImage!.path);
        try {
          await reference.putFile(file);
          loadImageFromFirebaseStorage();
        } catch (e) {
          print('Erro ao fazer o upload da imagem para o Firebase Storage: $e');
        }
      }
    }
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    String email = emailController.text;
    String password = senhaController.text;
    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário autenticado."),
        duration: Duration(seconds: 2),
      ));

      Navigator.of(context).pushReplacementNamed(RoutePaths.TAREFA_LIST_SCREEN);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${e}"),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: const InputDecoration(labelText: "E-mail"),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: senhaController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Senha"),
          ),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => {login()},
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(RoutePaths.CREATE_USER),
            child: const Text(
              "Criar usuário",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            child: Text('Selecionar imagem da câmera'),
          ),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: Text('Selecionar imagem da galeria'),
          ),
          if (_pickedImage != null)
            Container(
              width: 300,
              height: 300,
              child: Image.file(
                File(_pickedImage!.path),
                fit: BoxFit.cover,
              ),
            ),
          if (imageUrl != null)
            Container(
              width: 300,
              height: 300,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
        ]),
      ),
    );
  }
}

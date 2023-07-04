import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/route_paths.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> criarUsuario() async {
    String email = emailController.text;
    String password = senhaController.text;
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário criado com sucesso."),
        duration: Duration(seconds: 2),
      ));

      Navigator.of(context).pushReplacementNamed(RoutePaths.SIGN_IN_SCREEN);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${e}"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar usuário"),
      ),
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => criarUsuario(),
                  child: const Text("Salvar"),
                ),
              ),
              const SizedBox(width: 10), // Espaçamento entre os botões
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(RoutePaths.SIGN_IN_SCREEN),
                  child: const Text("Cancelar"),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

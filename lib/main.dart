import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/firebase_options.dart';
import 'package:projeto_lista_de_tarefas/routes/route_paths.dart';
import 'package:projeto_lista_de_tarefas/screens/create_user.dart';
import 'package:projeto_lista_de_tarefas/screens/sign_in_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_edit_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_insert_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_show_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_list_screen.dart';

//import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

void main() async {
  /*final Calculator calculator = Calculator();
  print(calculator.addOne(1));*/

  /* Os testes estão no pacote */

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //
        routes: {
          RoutePaths.SIGN_IN_SCREEN: (context) => SignInScreen(),
          RoutePaths.TAREFA_LIST_SCREEN: (context) => TarefaListScreen(),
          RoutePaths.TAREFA_SHOW_SCREEN: (context) => TarefaShowScreen(),
          RoutePaths.TAREFA_INSERT_SCREEN: (context) => TarefaInsertScreen(),
          RoutePaths.TAREFA_EDIT_SCREEN: (context) => TarefaEditScreen(),
          RoutePaths.CREATE_USER: (context) => CreateUser(),
        });
  }
}

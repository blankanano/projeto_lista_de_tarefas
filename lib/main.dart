import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/routes/route_paths.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_edit_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_insert_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_show_screen.dart';
import 'package:projeto_lista_de_tarefas/screens/tarefa_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //
        routes: {
          RoutePaths.HOME: (context) => TarefaListScreen(),
          RoutePaths.TAREFASHOWSCREEN: (context) => TarefaShowScreen(),
          RoutePaths.TAREFAINSERTSCREEN: (context) => TarefaInsertScreen(),
          RoutePaths.TAREFAEDITSCREEN: (context) => TarefaEditScreen(),
        });
  }
}

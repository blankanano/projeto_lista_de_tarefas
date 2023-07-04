import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/providers/tarefas_provider.dart';
import 'package:projeto_lista_de_tarefas/routes/route_paths.dart';
import 'package:provider/provider.dart';

import '../components/tarefa_list.dart';

class TarefaListScreen extends StatefulWidget {
  TarefaListScreen({super.key});

  @override
  State<TarefaListScreen> createState() => _TarefaListScreenState();
}

class _TarefaListScreenState extends State<TarefaListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TarefasProvider>(
      create: (context) => TarefasProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Tarefas - Melhorada"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RoutePaths.SIGN_IN_SCREEN)
                  .then((_) {});
            },
          ),
        ),
        body: Column(
          children: const [
            TarefaList(),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<TarefasProvider>(
            builder: (context, value, Widget? child) {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RoutePaths.TAREFA_INSERT_SCREEN)
                      .then((_) {
                    // Atualiza a lista após retornar da tela de detalhes
                    Provider.of<TarefasProvider>(context, listen: false)
                        .refreshTarefas();
                  });
                },
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

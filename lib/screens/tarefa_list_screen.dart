import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/providers/tarefas_provider.dart';
import 'package:projeto_lista_de_tarefas/routes/route_paths.dart';
import 'package:provider/provider.dart';

import '../components/tarefa_list.dart';
import '../components/tarefa_overview_card.dart';

class TarefaListScreen extends StatefulWidget {
  TarefaListScreen({super.key});

  @override
  State<TarefaListScreen> createState() => _TarefaListScreenState();
}

class _TarefaListScreenState extends State<TarefaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas - Trabalho de Flutter"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TarefasProvider(),
        child: Column(
          children: const [
            // TarefaOverviewCard(),
            TarefaList(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(RoutePaths.TAREFAINSERTSCREEN);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:projeto_lista_de_tarefas/components/tarefa_list_item.dart';
import 'package:projeto_lista_de_tarefas/providers/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';
import '../services/tarefas_service.dart';

class TarefaList extends StatelessWidget {
  const TarefaList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _generateListTarefas(List<Tarefa> tarefas) {
      return tarefas.map((tarefa) => TarefaListItem(tarefa)).toList();
    }

    return FutureBuilder<List<Tarefa>>(
      future: TarefasService().list(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao consultar dados: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final list = snapshot.data;
          if (list != null && list.isNotEmpty) {
            return Expanded(
              child: ListView(
                children: _generateListTarefas(list),
              ),
            );
          } else {
            return const Center(
              child: Text("Nenhuma tarefa cadastrada."),
            );
          }
        } else {
          return const Center(
            child: Text("Nenhuma tarefa cadastrada."),
          );
        }
      },
    );
  }
}

import 'package:projeto_lista_de_tarefas/providers/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefaOverviewCard extends StatelessWidget {
  const TarefaOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefas = Provider.of<TarefasProvider>(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Total de tarefas = ",
            style: TextStyle(fontSize: 20.0),
          ),
          Column(
            children: [
              Text(
                "${tarefas.countItens()}",
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

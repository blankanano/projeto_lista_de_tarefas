import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/models/tarefa.dart';

class TarefaShowScreen extends StatelessWidget {
  const TarefaShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(
        title: Text(tarefa.nome),
      ),
      body: Column(
        children: [
          Text(
            tarefa.nome,
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(
            tarefa.dataHora,
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(
            tarefa.localizacao,
            style: const TextStyle(fontSize: 20.0),
          )
        ],
      ),
    );
  }
}

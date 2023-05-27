import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';

import '../functions/funcoes_padrao.dart';

class TarefaInsertScreen extends StatefulWidget {
  const TarefaInsertScreen({super.key});

  @override
  State<TarefaInsertScreen> createState() => _TarefaInsertScreenState();
}

class _TarefaInsertScreenState extends State<TarefaInsertScreen> {
  final _nome = TextEditingController();
  final _dataHora = TextEditingController();
  final _localizacao = TextEditingController();

  final tarefasService = TarefasService();

  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      _localizacao.text = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nome,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),
            TextField(
              controller: _dataHora,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Data",
              ),
            ),
            TextField(
              controller: _localizacao,
              decoration: const InputDecoration(
                labelText: "Localização",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Tarefa tarefa = Tarefa(
                  _nome.text,
                  _dataHora.text,
                  _localizacao.text,
                );
                tarefasService.insert(tarefa);
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

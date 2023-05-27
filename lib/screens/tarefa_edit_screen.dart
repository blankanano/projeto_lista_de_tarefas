import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';
import 'package:projeto_lista_de_tarefas/functions/funcoes_padrao.dart';

class TarefaEditScreen extends StatefulWidget {
  const TarefaEditScreen({super.key});

  @override
  State<TarefaEditScreen> createState() => _TarefaEditScreenState();
}

class _TarefaEditScreenState extends State<TarefaEditScreen> {
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
    Tarefa tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    if (tarefa != null) {
      _nome.text = tarefa.nome;
      _dataHora.text = tarefa.dataHora;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edição"),
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

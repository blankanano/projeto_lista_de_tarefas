import 'package:flutter/services.dart';
//import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';
import 'package:projeto_lista_de_tarefas/functions/funcoes_padrao.dart';
import 'package:intl/intl.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

class TarefaEditScreen extends StatefulWidget {
  const TarefaEditScreen({super.key});

  @override
  State<TarefaEditScreen> createState() => _TarefaEditScreenState();
}

class _TarefaEditScreenState extends State<TarefaEditScreen> {
  final _nome = TextEditingController();
  DateTime _dataHora = DateTime.now();
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
  void dispose() {
    _nome.dispose();
    _localizacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    if (tarefa != null) {
      _nome.text = tarefa.nome;
      _dataHora = tarefa.dataHora;
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
            TextButton(
              onPressed: () {
                showDateTimePicker();
              },
              child: Text(
                _dataHora != null
                    ? DateFormat('dd/MM/yyyy HH:mm').format(_dataHora)
                    : 'Selecione a Data e Hora',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextField(
              readOnly: true,
              maxLines: null, // Ajusta automaticamente o número de linhas
              controller: TextEditingController(text: tarefa.localizacao),
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Localização',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tarefa.nome = _nome.text;
                tarefa.dataHora = _dataHora;
                tarefa.localizacao = _localizacao.text;

                tarefasService.update(tarefa.id.toString(), tarefa);
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDateTimePicker() async {
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _dataHora != null ? _dataHora : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _dataHora != null ? _dataHora : DateTime.now(),
        ),
      );

      if (pickedTime != null) {
        _dataHora = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }
}

import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../functions/funcoes_padrao.dart';
import 'package:intl/intl.dart';

class TarefaInsertScreen extends StatefulWidget {
  const TarefaInsertScreen({super.key});

  @override
  State<TarefaInsertScreen> createState() => _TarefaInsertScreenState();
}

class _TarefaInsertScreenState extends State<TarefaInsertScreen> {
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
              maxLength: 50,
              //maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (dateTime) {
                    setState(() {
                      _dataHora = dateTime;
                    });
                  },
                  currentTime: _dataHora ?? DateTime.now(),
                );
              },
              child: Text(
                _dataHora != null
                    ? DateFormat('dd/MM/yyyy hh:mm').format(_dataHora)
                    : 'Selecione a Data e Hora',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextField(
              readOnly: true,
              maxLines: null, // Ajusta automaticamente o número de linhas
              controller: _localizacao,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Localização',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Tarefa tarefa = Tarefa(
                  _nome.text,
                  _dataHora,
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

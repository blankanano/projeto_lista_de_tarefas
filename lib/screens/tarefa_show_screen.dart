import 'package:flutter/material.dart';
//import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:intl/intl.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

class TarefaShowScreen extends StatelessWidget {
  const TarefaShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            initialValue: tarefa.nome,
            readOnly: true,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            initialValue:
                DateFormat('dd/MM/yyyy HH:mm').format(tarefa.dataHora),
            readOnly: true,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              labelText: 'Data e Hora',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
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
        ],
      ),
    );
  }
}

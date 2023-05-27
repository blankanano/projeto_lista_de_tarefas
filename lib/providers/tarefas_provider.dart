import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';
import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class TarefasProvider with ChangeNotifier {
  List<Tarefa> tarefas = [];
  List<Tarefa> _tarefas = [];

  Future<List<Tarefa>> list() async {
    if (tarefas.isEmpty) {
      tarefas = await TarefasService().list();
    }
    return tarefas;
  }

  int countItens() => tarefas.fold(0, (acc, p) => acc);

  void deleteTarefa(Tarefa tarefa) async {
    String idTarefa = tarefa.id.toString();

    bool isDeleted = await TarefasService().delete(idTarefa);
    if (isDeleted) {
      tarefas.remove(tarefa);
      notifyListeners();
    }
  }

  Future<void> refreshTarefas() async {
    try {
      // Chame o serviço ou a função responsável por buscar as tarefas atualizadas
      List<Tarefa> tarefas = await TarefasService().list();
      // Atualize a lista de tarefas no provider
      _tarefas = tarefas;
      // Notifique os ouvintes (widgets dependentes) que os dados foram atualizados
      notifyListeners();
    } catch (error) {
      // Trate qualquer erro que ocorrer durante a atualização das tarefas
      print('Erro ao atualizar as tarefas: $error');
    }
  }
}

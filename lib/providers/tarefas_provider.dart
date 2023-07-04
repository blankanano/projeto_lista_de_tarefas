import 'package:projeto_lista_de_tarefas/services/tarefas_service.dart';
import 'package:flutter/material.dart';

//import '../models/tarefa.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

class TarefasProvider with ChangeNotifier {
  List<Tarefa> tarefas = [];
  List<Tarefa> _tarefas = [];

  Future<List<Tarefa>> list() async {
    if (tarefas.isEmpty) {
      tarefas = await TarefasService().list();
    }
    return tarefas;
  }

  void deleteTarefa(Tarefa tarefa) {
    String idTarefa = tarefa.id.toString();

    TarefasService().delete(idTarefa).then((isDeleted) {
      if (isDeleted) {
        tarefas.remove(tarefa);
        notifyListeners();
      }
    }).catchError((error) {
      print('Erro ao excluir a tarefa: $error');
    });
  }

  Future<void> refreshTarefas() async {
    try {
      // Chame o serviço ou a função responsável por buscar as tarefas atualizadas
      List<Tarefa> tarefas = await TarefasService().list();
      // Atualize a lista de tarefas no provider
      _tarefas = tarefas;

      await Future.delayed(const Duration(milliseconds: 100));
      // Notifique os ouvintes (widgets dependentes) que os dados foram atualizados
      notifyListeners();
    } catch (error) {
      // Trate qualquer erro que ocorrer durante a atualização das tarefas
      print('Erro ao atualizar as tarefas: $error');
    }
  }
}

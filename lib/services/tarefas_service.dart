import 'dart:convert';

//import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:projeto_lista_de_tarefas/repositories/tarefas_repository.dart';
import 'package:http/http.dart';
import 'package:consultor_tarefas_pk/consultor_tarefas_pk.dart';

class TarefasService {
  final TarefasRepository _tarefasRepository = TarefasRepository();

  Future<List<Tarefa>> list() async {
    try {
      Response response = await _tarefasRepository.list();

      if (response.statusCode == 200) {
        if ((response.body != null) && (response.body.isNotEmpty)) {
          var parsed = jsonDecode(response.body);
          if (parsed is Map<String, dynamic>) {
            Map<String, dynamic> json = jsonDecode(response.body);
            return Tarefa.listFromJson(json);
          } else {
            return [];
            throw Exception("Nenhuma tarefa cadastrada.");
          }
        } else {
          throw Exception("Nenhuma tarefa cadastrada.");
        }
      } else {
        throw Exception("Problemas ao consultar a tarefa.");
      }
    } catch (err) {
      throw Exception("Problemas ao consultar a tarefa.");
    }
  }

  Future<String> insert(Tarefa tarefa) async {
    try {
      String json = jsonEncode(tarefa.toJson());
      Response response = await _tarefasRepository.insert(json);

      if (response.statusCode == 200) {
        // Sucesso na requisição
        return jsonDecode(response.body) as String;
      } else {
        // Erro na requisição
        throw Exception("Erro ao inserir a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao inserir a tarefa: $err");
    }
  }

  Future<bool> delete(String id) async {
    try {
      Response response = await _tarefasRepository.delete(id);

      if (response.statusCode == 200) {
        // Sucesso na requisição
        return true;
      } else {
        // Erro na requisição
        throw Exception("Erro ao excluir a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao excluir a tarefa: $err");
    }
  }

  Future<bool> update(String id, Tarefa tarefa) async {
    try {
      String json = jsonEncode(tarefa.toJson());
      Response response = await _tarefasRepository.update(id, json);

      if (response.statusCode == 200) {
        // Sucesso na requisição
        return true;
      } else {
        // Erro na requisição
        throw Exception("Erro ao atualizar a tarefa: ${response.statusCode}");
      }
    } catch (err) {
      throw Exception("Problemas ao atualizar a tarefa: $err");
    }
  }
}

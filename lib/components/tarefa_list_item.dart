import 'package:projeto_lista_de_tarefas/models/tarefa.dart';
import 'package:projeto_lista_de_tarefas/providers/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';
import 'package:intl/intl.dart';

class TarefaListItem extends StatelessWidget {
  const TarefaListItem(
    this.tarefa, {
    super.key,
  });

  final Tarefa tarefa;

  // @override
  // Widget build(BuildContext context) {
  //   final _tarefasProvider = Provider.of<TarefasProvider>(context);
  //   return ListTile(
  //     title: Text(tarefa.nome),
  //     subtitle: Text(tarefa.dataHora),
  //     trailing: IconButton(
  //       icon: const Icon(Icons.delete),
  //       onPressed: () => _tarefasProvider.deleteTarefa(tarefa),
  //     ),
  //     onTap: () {
  //       Navigator.of(context)
  //           .pushNamed(RoutePaths.TAREFASHOWSCREEN, arguments: tarefa);
  //       _tarefasProvider
  //           .refreshTarefas(); // Atualiza a lista após retornar da tela de detalhes
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final _tarefasProvider = Provider.of<TarefasProvider>(context);

    return ListTile(
      title: Text(tarefa.nome),
      subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(tarefa.dataHora)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RoutePaths.TAREFAEDITSCREEN, arguments: tarefa)
                  .then((_) {
                // Atualiza a lista após retornar da tela de edição
                _tarefasProvider.refreshTarefas();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('Deseja excluir a tarefa?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () {
                          _tarefasProvider.deleteTarefa(tarefa);
                          Navigator.of(context).pop();
                          // Atualiza a lista após excluir a tarefa
                          _tarefasProvider.refreshTarefas();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutePaths.TAREFASHOWSCREEN, arguments: tarefa)
            .then((_) {
          // Atualiza a lista após retornar da tela de detalhes
          _tarefasProvider.refreshTarefas();
        });
      },
    );
  }
}

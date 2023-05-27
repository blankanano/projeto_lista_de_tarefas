class Tarefa {
  String? id;
  String nome;
  String dataHora;
  String localizacao;

  Tarefa(this.nome, this.dataHora, this.localizacao);

  Tarefa.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        dataHora = json['dataHora'],
        localizacao = json['localizacao'];

  Map<String, dynamic> toJson() =>
      {'nome': nome, 'dataHora': dataHora, 'localizacao': localizacao};

  static List<Tarefa> listFromJson(Map<String, dynamic> json) {
    try {
      List<Tarefa> tarefas = [];
      json.forEach((key, value) {
        Map<String, dynamic> item = {"id": key, ...value};
        tarefas.add(Tarefa.fromJson(item));
      });
      return tarefas;
    } catch (error) {
      print("Erro ao converter o JSON para a lista de tarefas: $error");
      return []; // Retorna uma lista vazia em caso de erro na conversão
    }
  }
}

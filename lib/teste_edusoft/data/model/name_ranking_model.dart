class NameRankingModel {
  String? nome;
  int? frequencia;
  int? ranking;

  NameRankingModel({
    this.nome,
    this.frequencia,
    this.ranking
  });

  factory NameRankingModel.fromJson(Map<String, dynamic>? json) {
    if(json == null) {
      return NameRankingModel();
    }
    return NameRankingModel(
      nome: json["nome"],
      frequencia: json["frequencia"],
      ranking: json["ranking"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'frequencia': frequencia,
      'ranking': ranking,
    };
  }
}
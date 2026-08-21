import 'package:teste_edusoft/teste_edusoft/data/model/name_ranking_model.dart';

class RankingModel {
  String? localidade;
  String? sexo;
  List<NameRankingModel>? res;

  RankingModel({
    this.localidade,
    this.sexo,
    this.res
  });

  factory RankingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RankingModel();
    }
    List<NameRankingModel>? res;
    if (json['res'] != null) {
      res = <NameRankingModel>[];
      json['res'].forEach((v) {
        res!.add(NameRankingModel.fromJson(v));
      });
    }
    return RankingModel(
      localidade: json['localidade'],
      sexo: json['sexo'],
      res: res
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localidade': localidade,
      'sexo': sexo,
      'res': res,
    };
  }
}
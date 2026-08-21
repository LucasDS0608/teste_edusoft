import 'package:teste_edusoft/teste_edusoft/data/model/frequency_detail_model.dart';

class DetailModel {
  String? nome;
  String? localidade;
  String? sexo;
  List<FrequencyDetailModel>? res;

  DetailModel({
    this.nome,
    this.localidade,
    this.sexo,
    this.res
  });

  factory DetailModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DetailModel();
    }
    List<FrequencyDetailModel>? res;
    if (json['res'] != null) {
      res = <FrequencyDetailModel>[];
      json['res'].forEach((v) {
        res!.add(FrequencyDetailModel.fromJson(v));
      });
    }
    return DetailModel(
      nome: json['nome'],
      localidade: json['localidade'],
      sexo: json['sexo'],
      res: res
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'localidade': localidade,
      'sexo': sexo,
      'res': res,
    };
  }
}
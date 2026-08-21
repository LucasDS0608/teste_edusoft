import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/ranking_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/provider/ibge_api_path.dart';

class IbgeRepository {

  Future<List<RankingModel>> getRanking() async{
    return await http.get(Uri.parse(IbgeApiPath.rankingPath)).then((result) {
      if (result.statusCode == 200) {
        return jsonDecode(result.body).map<RankingModel>((r) => RankingModel.fromJson(r)).toList();
      }
      throw Exception("Erro ao encontrar os eventos");
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }
  
  Future<List<DetailModel>> getDetails(String nome) async{
    return await http.get(Uri.parse("${IbgeApiPath.basePath}/$nome")).then((result) {
      if (result.statusCode == 200) {
        return jsonDecode(result.body).map<DetailModel>((r) => DetailModel.fromJson(r)).toList();
      }
      throw Exception("Erro ao encontrar os eventos");
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }
}
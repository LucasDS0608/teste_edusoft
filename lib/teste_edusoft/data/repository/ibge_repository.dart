import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/ranking_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/provider/ibge_api_path.dart';

class IbgeRepository {

  Future<List<RankingModel>> getRanking({String sexo = '', String localidade = ''}) async{
    var url = Uri.parse(IbgeApiPath.rankingPath);
  
    // Adiciona os query parameters dinamicamente se eles não forem vazios
    Map<String, String> queryParams = {};
    if (sexo.isNotEmpty) queryParams['sexo'] = sexo;
    if (localidade.isNotEmpty) queryParams['localidade'] = localidade;
    
    if (queryParams.isNotEmpty) {
      url = url.replace(queryParameters: queryParams);
    }
    return await http.get(url).then((result) {
      if (result.statusCode == 200) {
        return jsonDecode(result.body).map<RankingModel>((r) => RankingModel.fromJson(r)).toList();
      }
      throw Exception("Erro ao encontrar os eventos");
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }
  
  Future<List<DetailModel>> getDetails(String nome, {String sexo = '', String localidade = ''}) async{
    var url = Uri.parse('${IbgeApiPath.basePath}/$nome');
  
    // Adiciona os query parameters dinamicamente se eles não forem vazios
    Map<String, String> queryParams = {};
    if (sexo.isNotEmpty) queryParams['sexo'] = sexo;
    if (localidade.isNotEmpty) queryParams['localidade'] = localidade;
    
    if (queryParams.isNotEmpty) {
      url = url.replace(queryParameters: queryParams);
    }
    return await http.get(url).then((result) {
      if (result.statusCode == 200) {
        return jsonDecode(result.body).map<DetailModel>((r) => DetailModel.fromJson(r)).toList();
      }
      throw Exception("Erro ao encontrar os eventos");
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }
}
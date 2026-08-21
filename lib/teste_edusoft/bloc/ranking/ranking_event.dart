abstract class RankingEvent {}

class GetRanking extends RankingEvent{
  final String sexo;
  final String localidade;
  GetRanking({this.sexo = '', this.localidade = ''});
}

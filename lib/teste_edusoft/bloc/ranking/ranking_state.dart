import 'package:teste_edusoft/teste_edusoft/data/model/ranking_model.dart';

abstract class RankingState {
  final List<RankingModel> ranking;

  RankingState({required this.ranking});
}

class RankingInitialState extends RankingState {
  RankingInitialState() : super(ranking: []);
}

class RankingLoadingState extends RankingState {
  RankingLoadingState() : super(ranking: []);
}

class RankingLoadedgState extends RankingState {
  RankingLoadedgState({required super.ranking});
}

class RankingErrorgState extends RankingState {
  final Exception exception;
  
  RankingErrorgState({required this.exception}) : super(ranking: []);
}
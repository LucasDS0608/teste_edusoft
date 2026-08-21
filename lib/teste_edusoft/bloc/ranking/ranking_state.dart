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

class RankingLoadedState extends RankingState {
  RankingLoadedState({required super.ranking});
}

class RankingErrorState extends RankingState {
  final Exception exception;
  
  RankingErrorState({required this.exception}) : super(ranking: []);
}
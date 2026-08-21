import 'package:bloc/bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/ranking_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState>{
  final _repo = IbgeRepository();

  RankingBloc() : super(RankingInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(RankingEvent event, Emitter emit) async {
    List<RankingModel> ranking = [];
    emit(RankingLoadingState());
    if (event is GetRanking) {
      ranking = await _repo.getRanking();
    }
    emit(RankingLoadedgState(ranking: ranking));
  }
}
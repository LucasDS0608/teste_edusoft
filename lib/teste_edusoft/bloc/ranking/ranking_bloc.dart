import 'package:bloc/bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState>{
  final IbgeRepository _repo;

  RankingBloc({required this._repo}) : super(RankingInitialState()) {
    on<GetRanking>(_mapEventToState);
  }

  void _mapEventToState(RankingEvent event, Emitter emit) async {
    emit(RankingLoadingState());
    try {
      final ranking = await _repo.getRanking();
      emit(RankingLoadedState(ranking: ranking)); 
    } catch (e) {
      emit(RankingErrorState(exception: Exception("Falha ao carregar ranking: $e")));
    }
  }
}
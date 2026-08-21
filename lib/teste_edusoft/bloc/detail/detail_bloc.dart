import 'package:bloc/bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState>{
  final IbgeRepository repo;

  DetailBloc({required this.repo}) : super(DetailInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(DetailEvent event, Emitter emit) async {
    List<DetailModel> detailMasc = [];
    List<DetailModel> detailFem = [];
    emit(DetailLoadingState());
    if (event is GetDetail) {
      detailMasc = await repo.getDetails(event.nome, true);
      detailFem = await repo.getDetails(event.nome, false);
    }
    emit(DetailLoadedState(detailMasc: detailMasc, detailFem: detailFem));
  }
}
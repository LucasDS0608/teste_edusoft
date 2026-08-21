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
      if (event.sexo != null && event.sexo!.isNotEmpty) {
        if (event.sexo == 'M') {
          detailMasc = await repo.getDetails(event.nome, sexo: 'M', localidade: event.localidade ?? '');
        } else if (event.sexo == 'F') {
          detailFem = await repo.getDetails(event.nome, sexo: 'F', localidade: event.localidade ?? '');
        }
      } else {
        detailMasc = await repo.getDetails(event.nome, sexo: 'M', localidade: event.localidade ?? '');
        detailFem = await repo.getDetails(event.nome, sexo: 'F', localidade: event.localidade ?? '');
      }
    }
    emit(DetailLoadedState(detailMasc: detailMasc, detailFem: detailFem));
  }
}
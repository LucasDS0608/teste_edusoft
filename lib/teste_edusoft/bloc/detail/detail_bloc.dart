import 'package:bloc/bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState>{
  final IbgeRepository _repo;

  DetailBloc({required this._repo}) : super(DetailInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(DetailEvent event, Emitter emit) async {
    List<DetailModel> detail = [];
    emit(DetailLoadingState());
    if (event is GetDetail) {
      detail = await _repo.getDetails(event.nome);
    }
    emit(DetailLoadedState(detail: detail));
  }
}
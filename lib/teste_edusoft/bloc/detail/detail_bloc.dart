import 'package:bloc/bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState>{
  final _repo = IbgeRepository();

  DetailBloc() : super(DetailInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(DetailEvent event, Emitter emit) async {
    List<DetailModel> detail = [];
    emit(DetailLoadingState());
    if (event is GetDetail) {
      detail = await _repo.getDetails(event.nome);
    }
    emit(DetailLoadedgState(detail: detail));
  }
}
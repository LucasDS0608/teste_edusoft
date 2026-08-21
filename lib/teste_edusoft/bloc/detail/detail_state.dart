import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';

abstract class DetailState {
  final List<DetailModel> detailMasc;
  final List<DetailModel> detailFem;

  DetailState({required this.detailMasc, required this.detailFem});
}

class DetailInitialState extends DetailState {
  DetailInitialState() : super(detailMasc: [], detailFem: []);
}

class DetailLoadingState extends DetailState {
  DetailLoadingState() : super(detailMasc: [], detailFem: []);
}

class DetailLoadedState extends DetailState {
  DetailLoadedState({required super.detailMasc, required super.detailFem});
}

class DetailErrorState extends DetailState {
  final Exception exception;
  
  DetailErrorState({required this.exception}) : super(detailMasc: [], detailFem: []);
}
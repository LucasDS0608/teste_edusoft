import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';

abstract class DetailState {
  final List<DetailModel> detail;

  DetailState({required this.detail});
}

class DetailInitialState extends DetailState {
  DetailInitialState() : super(detail: []);
}

class DetailLoadingState extends DetailState {
  DetailLoadingState() : super(detail: []);
}

class DetailLoadedState extends DetailState {
  DetailLoadedState({required super.detail});
}

class DetailErrorState extends DetailState {
  final Exception exception;
  
  DetailErrorState({required this.exception}) : super(detail: []);
}
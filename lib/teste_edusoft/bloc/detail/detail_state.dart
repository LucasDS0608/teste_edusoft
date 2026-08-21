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

class DetailLoadedgState extends DetailState {
  DetailLoadedgState({required super.detail});
}

class DetailErrorgState extends DetailState {
  final Exception exception;
  
  DetailErrorgState({required this.exception}) : super(detail: []);
}
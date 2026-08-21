import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';
import 'package:teste_edusoft/teste_edusoft/view/details/localwidgets/gender_details_section.dart';

class DetailScreen extends StatelessWidget{
  final String nome;
  DetailScreen({super.key, required this.nome});

  final DetailBloc _detailBloc = DetailBloc(repo: IbgeRepository());

  @override
  Widget build(BuildContext context) {
    _detailBloc.add(GetDetail(nome: nome));
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        centerTitle: false,
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        bloc: _detailBloc,
        builder: (context, state) {
          if (state is DetailLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailLoadedState) {
            final itensMasc = state.detailMasc;
            final itensFem = state.detailFem;
            return SingleChildScrollView(
              child: Column(
                children: [
                  GenderDetailSection(items: itensMasc),
                  GenderDetailSection(items: itensFem),
                  const SizedBox(height: 32),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Erro"),
            );
          }
        },
      )
    );
  }
}
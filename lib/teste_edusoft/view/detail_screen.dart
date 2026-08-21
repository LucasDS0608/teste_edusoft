import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';

class DetailScreen extends StatelessWidget{
  final String nome;
  DetailScreen({super.key, required this.nome});

  final DetailBloc _detailBloc = DetailBloc();

  @override
  Widget build(BuildContext context) {
    _detailBloc.add(GetDetail(nome: nome));
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        bloc: _detailBloc,
        builder: (context, state) {
          if (state is DetailLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailLoadedgState) {
            final itens = state.detail;
            return ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                return Column(
                  children: [
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Nome: ${item.nome??"Não encontrado"}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Localidade: ${item.localidade??"Não encontrado"}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Sexo: ${item.sexo??"Não encontrado"}"),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.res?.length??0,
                      itemBuilder: (context, index) {
                        final res = item.res?[index];
                        return Card(
                          elevation: 4,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Periodo: ${res?.periodo?.replaceAll("[", "").replaceAll(",", " até ")}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Frequência: ${res?.frequencia}'),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                );
              },
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
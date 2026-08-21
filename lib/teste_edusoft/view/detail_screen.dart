import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/detail/detail_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';
import 'package:teste_edusoft/teste_edusoft/view/localwidgets/frequency_chart.dart';

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
            final itens = state.detailMasc;
            return ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Icon(Icons.person),
                          Text(item.nome??"Não encontrado")
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Icon(Icons.map),
                          Text("Localidade: ${item.localidade??"Não encontrado"}"),
                          Text(" | "),
                          Icon(Icons.male),
                          Icon(Icons.female),
                          Text("Sexo: ${item.sexo??"Não encontrado"}"),
                        ],
                      ),
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: item.res?.length??0,
                    //   itemBuilder: (context, index) {
                    //     final res = item.res?[index];
                    //     return Card(
                    //       elevation: 4,
                    //       child: Wrap(
                    //         alignment: WrapAlignment.center,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text('Periodo: ${res?.periodo?.replaceAll("[", "").replaceAll(",", " até ")}'),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text('Frequência: ${res?.frequencia}'),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // )
                    FrequencyChart(dados: item.res!).build(context)
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
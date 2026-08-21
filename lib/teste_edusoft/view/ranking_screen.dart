import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';
import 'package:teste_edusoft/teste_edusoft/view/detail_screen.dart';

class RankingScreen extends StatelessWidget {
  RankingScreen({super.key});

  final RankingBloc _rankingBloc = RankingBloc(repo: IbgeRepository());

  @override
  Widget build(BuildContext context) {
    _rankingBloc.add(GetRanking());
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste Edusoft"),
        centerTitle: true,
      ),
      body: BlocBuilder<RankingBloc, RankingState>(
        bloc: _rankingBloc, 
        builder: (context, state) {
          if (state is RankingLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RankingLoadedState) {
            final list = state.ranking;
            return ListView.builder(
              itemCount: list[0].res?.length??0,
              itemBuilder: (context, index) {
                final item = list[0].res?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(nome: item.nome ?? ""),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text("Ranking: ${item!.ranking.toString()}", style: TextStyle(fontWeight: FontWeight(700)),),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Nome: ${item.nome??"Não encontrado"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Frequência: ${item.frequencia.toString()}"),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Erro"),
            );
          }
        }
      )
    );
  }
}
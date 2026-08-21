import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_bloc.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_event.dart';
import 'package:teste_edusoft/teste_edusoft/bloc/ranking/ranking_state.dart';
import 'package:teste_edusoft/teste_edusoft/data/repository/ibge_repository.dart';
import 'package:teste_edusoft/teste_edusoft/view/details/detail_screen.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  
  late final RankingBloc _rankingBloc;

  String selectedSexo = '';
  String selectedUf = '';

  static const Map<String, String> _ufs = {
    'Todos': '', 'AC': '12', 'AL': '27', 'AP': '16', 'AM': '13', 'BA': '29',
    'CE': '23', 'DF': '53', 'ES': '32', 'GO': '52', 'MA': '21',
    'MT': '51', 'MS': '50', 'MG': '31', 'PA': '15', 'PB': '25',
    'PR': '41', 'PE': '26', 'PI': '22', 'RJ': '33', 'RN': '24',
    'RS': '43', 'RO': '11', 'RR': '14', 'SC': '42', 'SP': '35',
    'SE': '28', 'TO': '17',
  };

  // Método para disparar a busca sempre que um filtro mudar
  void _aplicarFiltros() {
    context.read<RankingBloc>().add(
      GetRanking(sexo: selectedSexo, localidade: selectedUf)
    );
  }

  @override
  void initState() {
    super.initState();
    _rankingBloc = RankingBloc(repo: IbgeRepository());
    _rankingBloc.add(GetRanking());
  }

  @override
  void dispose() {
    _rankingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nomes mais usados"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Dropdown de Sexo
                DropdownButton<String>(
                  value: selectedSexo,
                  items: const [
                    DropdownMenuItem(value: '', child: Text('Ambos')),
                    DropdownMenuItem(value: 'M', child: Text('Masculino')),
                    DropdownMenuItem(value: 'F', child: Text('Feminino')),
                  ],
                  onChanged: (val) {
                    setState(() => selectedSexo = val!);
                    _aplicarFiltros();
                  },
                ),
                // Dropdown de UF
                DropdownButton<String>(
                  value: selectedUf,
                  items: _ufs.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.key),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => selectedUf = val!);
                    _aplicarFiltros();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<RankingBloc, RankingState>(
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
                              builder: (context) => DetailScreen(
                                nome: item.nome ?? "",
                                sexo: selectedSexo, // Manda o filtro atual
                                localidade: selectedUf
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            leading: Text(item!.ranking.toString(), style: TextStyle(fontWeight: FontWeight(700)),),
                            title: Text(item.nome??"Não encontrado"),
                            subtitle: Row(
                              children: [
                                Icon(Icons.insert_chart),
                                Text(item.frequencia.toString()),
                              ],
                            ),
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
          )
        ],
      )
    );
  }
}
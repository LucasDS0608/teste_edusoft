import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/frequency_detail_model.dart'; //[cite: 6]

class FrequencyChart extends StatelessWidget {
  final List<FrequencyDetailModel> dados;

  const FrequencyChart({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    // Pegando o maior valor para definir o teto do gráfico
    double maxY = 0;
    for (var item in dados) {
      if ((item.frequencia ?? 0) > maxY) {
        maxY = item.frequencia!.toDouble();
      }
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            maxY: maxY + (maxY * 0.1), // Dá um respiro de 10% no topo
            barTouchData: BarTouchData(enabled: true), // Tooltip ao clicar!
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < dados.length) {
                      // Limpando a string do IBGE: de "[1930,1940[" para "1930"
                      final periodoCru = dados[index].periodo ?? "";
                      final label = periodoCru.replaceAll("[", "").split(",").first;
                      
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false), // Tira as bordas feias do gráfico
            gridData: const FlGridData(show: true, drawVerticalLine: false), // Apenas linhas horizontais
            barGroups: dados.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: item.frequencia?.toDouble() ?? 0,
                    color: Theme.of(context).primaryColor,
                    width: 16, // Largura da coluna
                    borderRadius: BorderRadius.circular(4), // Cantos arredondados
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
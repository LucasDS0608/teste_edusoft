import 'package:flutter/material.dart';
import 'package:teste_edusoft/teste_edusoft/data/model/detail_model.dart';
import 'package:teste_edusoft/teste_edusoft/view/details/localwidgets/frequency_chart.dart';

class GenderDetailSection extends StatelessWidget {
  final List<DetailModel> items;

   const GenderDetailSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return  SizedBox.shrink();

    return ListView.builder(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final iconSexo = item.sexo == 'F' ? Icons.female : Icons.male;
        return Card(
          margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                     Icon(Icons.person, color: Colors.grey),
                     SizedBox(width: 8),
                    Text(
                      item.nome ?? "Não encontrado", 
                      style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ]
                ),
                Divider(),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                     SizedBox(width: 4),
                    Text(item.localidade??'BR'),
                     Text("  |  ", style: TextStyle(color: Colors.grey)),
                    Icon(iconSexo, size: 16, color: Colors.grey),
                     SizedBox(width: 4),
                    Text("Sexo: ${item.sexo ?? "Não encontrado"}"),
                  ],
                ),
                 SizedBox(height: 16),
                FrequencyChart(dados: item.res ?? []),
              ],
            ),
          ),
        );
      },
    );
  }
}
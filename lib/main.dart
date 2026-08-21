import 'package:flutter/material.dart';
import 'package:teste_edusoft/teste_edusoft/view/ranking_screen.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teste Edusoft',
        debugShowCheckedModeBanner: false,
        home: RankingScreen(), 
    );
  }
}
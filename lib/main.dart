import 'package:flutter/material.dart';
import 'package:teste_edusoft/teste_edusoft/view/ranking/ranking_screen.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
        primaryColor: const Color(0xFF1E293B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B),
          secondary: const Color(0xFF06B6D4), // O ciano do detalhe
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F7F6), // Fundida com o Scaffold
          elevation: 0, // Sem sombra para ficar clean
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1E293B)), // Setinha de voltar escura
          titleTextStyle: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Cantinhos modernos
          ),
        ),
        useMaterial3: true,
      ),
      home: RankingScreen(), 
    );
  }
}
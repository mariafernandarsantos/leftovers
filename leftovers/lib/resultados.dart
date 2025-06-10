import 'package:flutter/material.dart';
import 'models/receita.dart';
import 'receita.dart';

class ResultadosPage extends StatelessWidget {
  final List<Receita> receitas;

  const ResultadosPage({super.key, required this.receitas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E4),
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Receitas Encontradas', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: receitas.length,
        itemBuilder: (context, index) {
          final receita = receitas[index];
          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Image.network(receita.imagem, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(receita.titulo),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceitaPage(receita: receita),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ReceitaPage extends StatelessWidget {
  const ReceitaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E4), // mesma cor do fundo do início.dart
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/ratatouille.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal[900], // fundo do botão de voltar
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal[900],
                        child: IconButton(
                          icon: const Icon(Icons.bookmark_border, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.teal[900],
                        child: IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ratatuille',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'INGREDIENTES',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• 3 aguma coisa'),
                  Text('• 5 colhetes de aguma coisa'),
                  Text('• 1 xícara de água'),
                  Text('• 1/3 requeijão'),
                  Text('• Páprica'),
                  Text('• Sangue de galinha'),
                  SizedBox(height: 24),
                  Text(
                    'Modo de preparo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Comece lavando bem todos os ingredientes. Em uma panela grande, aqueça um fio de azeite e refogue os temperos por alguns minutos. '
                    'Adicione os legumes picados e cozinhe em fogo médio, mexendo ocasionalmente. Quando estiverem macios, adicione a água e deixe ferver por 10 minutos. '
                    'Acrescente o requeijão e a páprica, misturando até formar um molho cremoso. '
                    'Cozinhe por mais 5 minutos, ajuste o sal e sirva ainda quente. Ideal para acompanhar arroz branco ou uma salada leve.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
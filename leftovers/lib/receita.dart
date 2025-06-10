import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';  // IMPORTAÇÃO DO PACOTE
import 'models/receita.dart';
import 'api_service.dart';

class ReceitaPage extends StatefulWidget {
  final Receita receita;

  const ReceitaPage({super.key, required this.receita});

  @override
  State<ReceitaPage> createState() => _ReceitaPageState();
}

class _ReceitaPageState extends State<ReceitaPage> {
  late Future<Receita> receitaDetalhada;

  @override
  void initState() {
    super.initState();
    receitaDetalhada = _carregarDetalhesReceita();
  }

  Future<Receita> _carregarDetalhesReceita() async {
    final dados = await SpoonacularService.buscaDetalhesReceita(widget.receita.id);
    return Receita.fromJson(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E4),
      body: FutureBuilder<Receita>(
        future: receitaDetalhada,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar receita: ${snapshot.error}'));
          }
          final receita = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      receita.imagem,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.teal[900],
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(receita.titulo,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      const Text('Ingredientes:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...receita.ingredientes.map((ing) => Text(
                            '• ${ing.quantidade} de ${ing.nome}',
                            style: const TextStyle(fontSize: 16),
                          )),
                      const SizedBox(height: 24),
                      const Text('Modo de preparo:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      receita.instrucoes.isNotEmpty
                          ?Html(
                              data: receita.instrucoes,
                              style: {
                                "ol": Style(
                                  padding: HtmlPaddings.only(left: 20),
                                ),
                                "li": Style(
                                  fontSize: FontSize(16),
                                  padding: HtmlPaddings.symmetric(vertical: 6),
                                ),
                              },
                            )
                          : const Text(
                              'Instruções não disponíveis.',
                              style: TextStyle(fontSize: 16),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

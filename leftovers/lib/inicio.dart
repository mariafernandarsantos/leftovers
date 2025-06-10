import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'api_service.dart';
import 'models/receita.dart';
import 'resultados.dart';

class LeftoversHome extends StatefulWidget {
  @override
  State<LeftoversHome> createState() => _LeftoversHome();
}

class _LeftoversHome extends State<LeftoversHome> {
  final TextEditingController ingredienteController = TextEditingController();
  final List<String> ingredientesSelecionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E4),
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Leftovers', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: ingredienteController,
                decoration: InputDecoration(
                  hintText: 'Digite um ingrediente',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                if (pattern.isEmpty) return [];
                return await SpoonacularService.buscaIngredientes(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion));
              },
              onSuggestionSelected: (suggestion) {
                if (!ingredientesSelecionados.contains(suggestion)) {
                  setState(() {
                    ingredientesSelecionados.add(suggestion);
                  });
                }
                ingredienteController.clear();
              },
              noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Nenhum ingrediente encontrado'),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ingredientesSelecionados.map((ingrediente) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.teal[700],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.restaurant_menu, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(ingrediente, style: const TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ingredientesSelecionados.remove(ingrediente);
                          });
                        },
                        child: const Icon(Icons.close, color: Colors.white70, size: 18),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  if (ingredientesSelecionados.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adicione pelo menos um ingrediente')),
                    );
                    return;
                  }

                  try {
                    final data = await SpoonacularService.buscaReceitas(ingredientesSelecionados);
                    final receitas = data.map<Receita>((item) => Receita.fromJson(item)).toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultadosPage(receitas: receitas),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro: ${e.toString()}')),
                    );
                  }
                },
                child: const Text('Gerar Receita', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

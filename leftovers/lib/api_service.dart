import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  static const String apiKey = 'API_KEY';
  static const String baseUrl = 'https://api.spoonacular.com';

  
  static Future<List<String>> buscaIngredientes(String query) async {
    final url = Uri.parse(
      '$baseUrl/food/ingredients/autocomplete?query=$query&number=10&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map<String>((item) => item['name'] as String).toList();
    } else {
      throw Exception('Erro ao buscar sugestões');
    }
  }

  // 🍳 Busca receitas por ingredientes
  static Future<List<dynamic>> buscaReceitas(List<String> ingredientes) async {
    final ingredientesQuery = ingredientes.join(',');
    final url = Uri.parse(
      '$baseUrl/recipes/findByIngredients?ingredients=$ingredientesQuery&number=5&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao buscar receitas');
    }
  }
}

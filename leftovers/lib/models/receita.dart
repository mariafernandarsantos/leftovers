class Ingrediente {
  final String nome;
  final String quantidade;

  Ingrediente({required this.nome, required this.quantidade});

  factory Ingrediente.fromJson(Map<String, dynamic> json) {
    final amount = json['amount'].toString();
    final unit = json['unit'] ?? '';
    final name = json['name'] ?? '';
    return Ingrediente(nome: name, quantidade: '$amount $unit');
  }
}

class Receita {
  final int id;
  final String titulo;
  final String imagem;
  final List<Ingrediente> ingredientes;
  final String instrucoes;

  Receita({
    required this.id,
    required this.titulo,
    required this.imagem,
    this.ingredientes = const [],
    this.instrucoes = '',
  });

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'],
      titulo: json['title'],
      imagem: json['image'],
      ingredientes: json['extendedIngredients'] != null
          ? (json['extendedIngredients'] as List)
              .map((i) => Ingrediente.fromJson(i))
              .toList()
          : [],
      instrucoes: json['instructions'] ?? '',
    );
  }
}

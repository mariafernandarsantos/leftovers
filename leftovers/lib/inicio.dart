import 'package:flutter/material.dart';

class LeftoversHome extends StatefulWidget {
  @override
  State<LeftoversHome> createState() => _LeftoversHome();
}

class _LeftoversHome extends State<LeftoversHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFDF6E4),
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70, 
            tabs: [
              Tab(text: 'HISTÓRICO DE RECEITAS'),
              Tab(text: 'ME SURPREENDA'),
            ],
          ),
          title: Text(
            'Melhores receitas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'O que temos para hoje?',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              IngredientButton(
                label: 'Banana',
                imagePath: 'assets/images/banana.jpg',
              ),
              IngredientButton(
                label: 'Biscoito',
                imagePath: 'assets/images/biscoito.jpg',
              ),
              IngredientButton(
                label: 'Doce de leite',
                imagePath: 'assets/images/doce_de_leite.jpg',
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    print("Botao clicado");
                  },
                  child: Text(
                    'Gerar Receita',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientButton extends StatelessWidget {
  final String label;
  final String imagePath;

  const IngredientButton({
    required this.label,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          title: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
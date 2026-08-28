import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  Widget categoryItem(String name, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Text(name, style: const TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
        foregroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Entenda os ícones',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Cada ícone representa uma categoria.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                categoryItem(
                  'Alimentação',
                  Icons.restaurant,
                  Colors.deepOrange,
                ),
                categoryItem('Contas', Icons.receipt, Colors.teal),
                categoryItem('Lazer', Icons.sports_esports, Colors.purple),
                categoryItem('Mercado', Icons.shopping_cart, Colors.orange),
                categoryItem('Outros', Icons.more_horiz, Colors.grey),
                categoryItem('Salário', Icons.work, Colors.green),
                categoryItem('Transporte', Icons.directions_car, Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'As categorias são fixas nesta primeira versão.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

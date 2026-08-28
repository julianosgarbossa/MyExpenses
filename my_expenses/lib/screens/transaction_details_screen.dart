import 'package:flutter/material.dart';

import '../models/financial_transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({required this.transaction, super.key});

  final FinancialTransaction transaction;

  String formatDateAndTime(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day/$month/${date.year} às $hour:$minute';
  }

  String formatMoney(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  IconData categoryIcon() {
    switch (transaction.category) {
      case 'Alimentação':
        return Icons.restaurant;
      case 'Mercado':
        return Icons.shopping_cart;
      case 'Transporte':
        return Icons.directions_car;
      case 'Lazer':
        return Icons.sports_esports;
      case 'Contas':
        return Icons.receipt;
      case 'Salário':
        return Icons.work;
      default:
        return Icons.more_horiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);
    final transactionColor = transaction.isIncome ? green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Movimentação'),
        centerTitle: true,
        foregroundColor: green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: transactionColor.withValues(alpha: 0.12),
            child: Icon(categoryIcon(), color: transactionColor, size: 38),
          ),
          const SizedBox(height: 28),
          const Text('Descrição', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          SelectableText(
            transaction.description,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 36),
          const Text('Tipo', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            transaction.isIncome ? 'Entrada' : 'Saída',
            style: const TextStyle(fontSize: 17),
          ),
          const Divider(height: 36),
          const Text('Valor', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            formatMoney(transaction.value),
            style: TextStyle(
              color: transactionColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 36),
          const Text('Categoria', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(transaction.category, style: const TextStyle(fontSize: 17)),
          const Divider(height: 36),
          const Text('Data e hora', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            formatDateAndTime(transaction.date),
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}

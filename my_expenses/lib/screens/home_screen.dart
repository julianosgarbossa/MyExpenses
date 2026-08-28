import 'package:flutter/material.dart';

import '../models/financial_transaction.dart';
import 'categories_screen.dart';
import 'new_transaction_sheet.dart';
import 'transaction_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.initialBalance, super.key});

  final double initialBalance;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final transactions = <FinancialTransaction>[];

  double get totalIncome {
    return transactions
        .where((transaction) => transaction.isIncome)
        .fold(0, (total, transaction) => total + transaction.value);
  }

  double get totalExpense {
    return transactions
        .where((transaction) => !transaction.isIncome)
        .fold(0, (total, transaction) => total + transaction.value);
  }

  double get currentBalance {
    return widget.initialBalance + totalIncome - totalExpense;
  }

  Future<void> openTransactionSheet() async {
    final transaction = await showModalBottomSheet<FinancialTransaction>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const NewTransactionSheet(),
    );

    if (transaction != null) {
      setState(() {
        transactions.add(transaction);
        transactions.sort((a, b) => b.date.compareTo(a.date));
      });
    }
  }

  String formatMoney(double value) {
    final isNegative = value < 0;
    final valueParts = value.abs().toStringAsFixed(2).split('.');
    final number = valueParts[0];
    final cents = valueParts[1];
    final formattedNumber = StringBuffer();

    for (var index = 0; index < number.length; index++) {
      formattedNumber.write(number[index]);

      final remainingNumbers = number.length - index - 1;
      if (remainingNumbers > 0 && remainingNumbers % 3 == 0) {
        formattedNumber.write('.');
      }
    }

    if (isNegative) {
      return '- R\$ $formattedNumber,$cents';
    }

    return 'R\$ $formattedNumber,$cents';
  }

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  IconData categoryIcon(String category) {
    switch (category) {
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

  Color categoryColor(String category) {
    switch (category) {
      case 'Alimentação':
        return Colors.deepOrange;
      case 'Mercado':
        return Colors.orange;
      case 'Transporte':
        return Colors.blue;
      case 'Lazer':
        return Colors.purple;
      case 'Contas':
        return Colors.teal;
      case 'Salário':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Gastos',
          style: TextStyle(color: green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.grid_view_rounded, color: green, size: 30),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SALDO ATUAL',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatMoney(currentBalance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white54),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Entradas',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatMoney(totalIncome),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(color: Colors.white54),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Saídas',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatMoney(totalExpense),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Últimas movimentações',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: transactions.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Color(0xFFE5F3EE),
                              child: Icon(
                                Icons.receipt_long,
                                size: 65,
                                color: green,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Nenhuma movimentação registrada',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Adicione sua primeira entrada ou\nsaída para começar.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        itemCount: transactions.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          final color = categoryColor(transaction.category);
                          final signal = transaction.isIncome ? '+' : '-';

                          return InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionDetailsScreen(
                                        transaction: transaction,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: color.withValues(
                                      alpha: 0.12,
                                    ),
                                    child: Icon(
                                      categoryIcon(transaction.category),
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.description,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(formatDate(transaction.date)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '$signal ${formatMoney(transaction.value)}',
                                    style: TextStyle(
                                      color: transaction.isIncome
                                          ? green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: openTransactionSheet,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar movimentação'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

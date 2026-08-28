import 'package:flutter/material.dart';

import '../models/financial_transaction.dart';

class NewTransactionSheet extends StatefulWidget {
  const NewTransactionSheet({super.key});

  @override
  State<NewTransactionSheet> createState() => _NewTransactionSheetState();
}

class _NewTransactionSheetState extends State<NewTransactionSheet> {
  bool isIncome = false;
  String description = '';
  String valueText = '';
  String selectedCategory = 'Alimentação';

  final categories = [
    'Alimentação',
    'Contas',
    'Lazer',
    'Mercado',
    'Outros',
    'Salário',
    'Transporte',
  ];

  void saveTransaction() {
    final formattedValue = valueText.replaceAll('.', '').replaceAll(',', '.');
    final value = double.tryParse(formattedValue);

    if (description.trim().isEmpty || value == null || value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha a descrição e o valor')),
      );
      return;
    }

    final transaction = FinancialTransaction(
      description: description.trim(),
      value: value,
      date: DateTime.now(),
      category: selectedCategory,
      isIncome: isIncome,
    );

    Navigator.pop(context, transaction);
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 0, 20, keyboardHeight + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Nova movimentação',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isIncome = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isIncome ? green : Colors.white,
                    foregroundColor: isIncome ? Colors.white : Colors.black,
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('Entrada'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isIncome = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isIncome ? green : Colors.white,
                    foregroundColor: !isIncome ? Colors.white : Colors.black,
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('Saída'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Descrição'),
          const SizedBox(height: 6),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Ex.: Almoço',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              description = text;
            },
          ),
          const SizedBox(height: 18),
          const Text('Valor'),
          const SizedBox(height: 6),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixText: 'R\$ ',
              hintText: '0,00',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.check),
              ),
            ),
            onChanged: (text) {
              valueText = text;
            },
            onSubmitted: (text) {
              FocusScope.of(context).unfocus();
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 18),
          const Text('Categoria'),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: selectedCategory,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: categories.map((category) {
              return DropdownMenuItem(value: category, child: Text(category));
            }).toList(),
            onChanged: (category) {
              if (category != null) {
                selectedCategory = category;
              }
            },
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: saveTransaction,
              child: const Text('Adicionar movimentação'),
            ),
          ),
        ],
      ),
    );
  }
}

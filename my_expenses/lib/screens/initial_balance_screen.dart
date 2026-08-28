import 'package:flutter/material.dart';

import 'home_screen.dart';

class InitialBalanceScreen extends StatefulWidget {
  const InitialBalanceScreen({super.key});

  @override
  State<InitialBalanceScreen> createState() => _InitialBalanceScreenState();
}

class _InitialBalanceScreenState extends State<InitialBalanceScreen> {
  String balanceText = '';

  void start() {
    final formattedText = balanceText.replaceAll('.', '').replaceAll(',', '.');
    final balance = double.tryParse(formattedText);

    if (balance == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um saldo válido')));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(initialBalance: balance),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Gastos'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 65,
            backgroundColor: Color(0xFFE5F3EE),
            child: Icon(
              Icons.account_balance_wallet,
              size: 75,
              color: Color(0xFF087F5B),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Informe seu saldo atual',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Esse será o ponto de partida do seu controle.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Saldo inicial',
              prefixText: 'R\$ ',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.check),
              ),
            ),
            onChanged: (value) {
              balanceText = value;
            },
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: start,
              child: const Text('Começar'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'screens/initial_balance_screen.dart';

void main() {
  runApp(const MyExpensesApp());
}

class MyExpensesApp extends StatelessWidget {
  const MyExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF087F5B);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meus Gastos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FBFA),
        useMaterial3: true,
      ),
      home: const InitialBalanceScreen(),
    );
  }
}

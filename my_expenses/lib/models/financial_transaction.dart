class FinancialTransaction {
  FinancialTransaction({
    required this.description,
    required this.value,
    required this.date,
    required this.category,
    required this.isIncome,
  });

  final String description;
  final double value;
  final DateTime date;
  final String category;
  final bool isIncome;
}

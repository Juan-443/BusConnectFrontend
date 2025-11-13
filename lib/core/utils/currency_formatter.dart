import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    locale: 'es_BO',
    symbol: 'Bs.',
    decimalDigits: 2,
  );

  static final _formatterNoSymbol = NumberFormat.currency(
    locale: 'es_BO',
    symbol: '',
    decimalDigits: 2,
  );

  // Format: Bs. 150.50
  static String format(double amount) {
    return _formatter.format(amount);
  }

  // Format: 150.50
  static String formatWithoutSymbol(double amount) {
    return _formatterNoSymbol.format(amount).trim();
  }

  // Format: Bs. 150
  static String formatInteger(double amount) {
    return NumberFormat.currency(
      locale: 'es_BO',
      symbol: 'Bs.',
      decimalDigits: 0,
    ).format(amount);
  }

  // Format for input (allows decimal)
  static String formatForInput(String value) {
    if (value.isEmpty) return '';

    // Remove all non-numeric characters except decimal point
    value = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Parse to double
    final amount = double.tryParse(value);
    if (amount == null) return '';

    return formatWithoutSymbol(amount);
  }

  // Parse formatted string to double
  static double? parse(String formattedAmount) {
    // Remove currency symbol and spaces
    String cleaned = formattedAmount
        .replaceAll('Bs.', '')
        .replaceAll(' ', '')
        .replaceAll(',', '');

    return double.tryParse(cleaned);
  }

  // Validate amount
  static bool isValidAmount(String value) {
    if (value.isEmpty) return false;
    final amount = parse(value);
    return amount != null && amount >= 0;
  }

  // Format percentage
  static String formatPercentage(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  // Format compact (1K, 1M, etc.)
  static String formatCompact(double amount) {
    if (amount >= 1000000) {
      return 'Bs. ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Bs. ${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return format(amount);
    }
  }
}
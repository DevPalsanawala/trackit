import 'package:intl/intl.dart';

String formatCurrency(dynamic amount) {
  double numericAmount;
  if (amount is String) {
    numericAmount = double.parse(amount);
  } else if (amount is double) {
    numericAmount = amount;
  } else if (amount is int) {
    numericAmount = amount.toDouble();
  } else {
    throw FormatException('Amount must be a number or string');
  }
  return NumberFormat('#,##,##0.00').format(numericAmount);
}

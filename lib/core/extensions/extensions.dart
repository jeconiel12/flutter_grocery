import 'package:intl/intl.dart';

extension StringExtension on String {
  String toIDR() {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final amount = double.tryParse(this) ?? 0.0;
    return formatCurrency.format(amount);
  }
}

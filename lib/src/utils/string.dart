import 'package:intl/intl.dart';

String format(double n) {
  return NumberFormat.currency(
    locale: 'es',
    symbol: '',
  ).format(n);
}

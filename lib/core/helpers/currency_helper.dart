import 'package:intl/intl.dart';

abstract final class CurrencyHelper {
  static String format(num amount, {String symbol = r'$'}) =>
      NumberFormat.currency(symbol: symbol).format(amount);
}

import 'package:intl/intl.dart';

abstract final class DateHelper {
  static String format(DateTime date) => DateFormat.yMMMd().format(date);
}

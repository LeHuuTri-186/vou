import 'package:intl/intl.dart';

class DateTimeUtil {
  /// Formats a [DateTime] to the format 'MMM dd yyyy'.
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}
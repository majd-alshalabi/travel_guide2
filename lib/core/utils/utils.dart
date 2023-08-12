import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime dateFromStringUtcFormatted(String date) {
    var parsedDate = DateTime.parse(date).add(const Duration(hours: 3));
    return parsedDate;
  }

  static String dateToUtcFormattedForNotification(DateTime date) {
    try {
      return "${DateFormat.yMMMd().format(date)} ${DateFormat.jm().format(date)}";
    } catch (e) {
      return "";
    }
  }

  static String dateToUtcFormattedForNotificationFromString(String date) {
    try {
      DateTime dateTime = dateFromStringUtcFormatted(date);
      return "${DateFormat.yMMMd().format(dateTime)} ${DateFormat.jm().format(dateTime)}";
    } catch (e) {
      return "";
    }
  }

  static void showCustomToast(String message) {
    Fluttertoast.showToast(
      fontSize: 9,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}

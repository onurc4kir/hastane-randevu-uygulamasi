import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';

abstract class HelperFunctions {
  static bool isUrlInternal({required String baseUrl, required Uri? uri}) {
    if (uri != null) {
      if (uri.host.isEmpty) {
        return true;
      }

      String baseUri = Uri.parse(baseUrl).host;
      if (uri.host.startsWith('www')) {
        baseUri = 'www.$baseUri';
      }
      if (baseUri == uri.host) {
        return true;
      }
    }

    return false;
  }

  static String formatDateForUi(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";
  }

  static String formatDateForQuery(DateTime date) {
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static String todayDate() {
    final date = DateTime.now();
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static String dateTimeToString(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString()}\n${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  static String removeHtmlTags({String? html}) {
    if (html == null) {
      return "";
    }

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedstring1 = html.replaceAll(exp, '');
    return parsedstring1;
//output without space:  HelloThis is fluttercampus.com,Bye!
  }

  static bool isTwoDateAtSameDay(DateTime first, DateTime second) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }

  static Future<bool> launchStringUrl(String url) async {
    if (Platform.isIOS) {
      return await launchUrlString(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      return await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

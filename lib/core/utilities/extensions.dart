import 'package:intl/intl.dart';
import 'package:randevu_al/components/custom_shaped_button.dart';
import 'package:flutter/material.dart';

extension TimeExtension on TimeOfDay {
  String get timeForUi {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}

extension DateExtension on DateTime {
  String get formattedDateForQuery {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formattedDateForUI {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get formattedDateForUIWithTime {
    return DateFormat('dd/MM/yyyy HH:mm').format(toLocal());
  }
}

extension ContextExtension on BuildContext {
  showSnackBarWithAction(
      {required String message,
      required String actionLabel,
      required VoidCallback action}) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: action,
      ),
    ));
  }

  showSnackBar({required String message}) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  showSuccessSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: duration,
    ));
  }

  showErrorDialog({
    String? title,
    required String message,
    VoidCallback? action,
  }) {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        content: Text(message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          CustomShapedButton(
            type: ButtonType.danger,
            onPressed: () {
              if (action != null) {
                action();
              }
              Navigator.pop(context);
            },
            text: "OK",
          ),
        ],
      ),
    );
  }

  showErrorSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: duration,
    ));
  }

  showLoadingIndicator() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  hideLoadingIndicator() {
    if (Navigator.canPop(this)) {
      return Navigator.pop(this);
    }
  }
}

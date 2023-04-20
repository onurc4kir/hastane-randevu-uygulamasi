import 'package:flutter/material.dart';
import 'package:randevu_al/components/custom_shaped_button.dart';

class DialogHelper {
  static Future<void> showErrorDialog(
      {required BuildContext context,
      String title = "Hata",
      String description = "Bir hata oluştu"}) {
    return showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(title,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(description,
                      style: Theme.of(context).textTheme.headlineSmall),
                  ElevatedButton(
                    onPressed: () {
                      if (ModalRoute.of(context)?.isCurrent != true) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Tamam"),
                  )
                ]),
              ),
            ));
  }

  static Future<dynamic> showCustomDialog({
    required BuildContext context,
    required Widget icon,
    String title = "INFO",
    String description = "OK",
    Widget? extraContent,
    String? okButtonText,
    String? cancelButtonText,
    VoidCallback? okButtonOnTap,
    VoidCallback? cancelButtonOnTap,
  }) {
    return showDialog(
        context: context,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: icon,
                        ),
                        const SizedBox(height: 48),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (extraContent != null) extraContent,
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (okButtonText != null)
                          CustomShapedButton(
                            textPadding: 16,
                            text: okButtonText,
                            type: ButtonType.primary,
                            onPressed:
                                okButtonOnTap ?? () => Navigator.pop(context),
                          ),
                        if (cancelButtonText != null)
                          CustomShapedButton(
                            textPadding: 16,
                            type: ButtonType.danger,
                            text: cancelButtonText,
                            isOutlined: true,
                            onPressed: cancelButtonOnTap ??
                                () => Navigator.pop(context),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}

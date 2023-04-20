import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/theme/colors.style.dart';

enum ButtonType {
  primary,
  secondary,
  danger,
  success,
  warning,
  info,
  light,
  disabled,
}

class CustomShapedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final ButtonType type;
  final bool isOutlined;
  final bool isExpanded;
  final double textPadding;
  final EdgeInsets margin;
  final bool enabled;
  final Size buttonSize;
  final bool isNotSuggested;
  final bool isLoading;

  const CustomShapedButton({
    Key? key,
    this.onPressed,
    this.text,
    this.type = ButtonType.primary,
    this.isOutlined = false,
    this.isExpanded = true,
    this.enabled = true,
    this.textPadding = 4,
    this.buttonSize = const Size(double.infinity, 45),
    this.isNotSuggested = false,
    this.isLoading = false,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: _getButton(),
    );
  }

  Widget _getButton() {
    final Color bgColor =
        isNotSuggested ? _getBgColor().withAlpha(100) : _getBgColor();
    final Widget textWidget = _getTextWidget();
    if (isOutlined) {
      return OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: bgColor),
          shape: const StadiumBorder(),
          minimumSize: isExpanded ? const Size(double.infinity, 40) : null,
          maximumSize: buttonSize,
        ),
        child: textWidget,
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: bgColor,
        minimumSize: isExpanded ? const Size(double.infinity, 40) : buttonSize,
        fixedSize: buttonSize,
        disabledBackgroundColor: IColors.disabledButtonColor,
      ),
      onPressed: enabled ? onPressed : null,
      child: textWidget,
    );
  }

  Color _getBgColor() {
    switch (type) {
      case ButtonType.primary:
        return IColors.primary;
      case ButtonType.secondary:
        return IColors.secondary;
      case ButtonType.danger:
        return IColors.redAccent;
      case ButtonType.success:
        return Colors.green;
      case ButtonType.warning:
        return Colors.yellow;
      case ButtonType.info:
        return IColors.blueAccent;
      case ButtonType.light:
        return Colors.white;
      case ButtonType.disabled:
        return IColors.disabledButtonColor;
      default:
        return IColors.primary;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return IColors.hintTextColor;
      case ButtonType.danger:
        return Colors.white;
      case ButtonType.light:
        return IColors.primary;
      case ButtonType.disabled:
        return IColors.hintTextColor;

      default:
        return Colors.white;
    }
  }

  Widget _getTextWidget() {
    return Padding(
      padding: EdgeInsets.all(textPadding),
      child: isLoading
          ? CupertinoActivityIndicator(
              color: _getTextColor(),
            )
          : Text(
              text ?? '',
              style: TextStyle(
                color: isOutlined ? _getBgColor() : _getTextColor(),
              ),
            ),
    );
  }
}

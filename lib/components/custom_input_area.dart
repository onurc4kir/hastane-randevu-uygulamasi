import 'package:flutter/material.dart';
import '../core/theme/colors.style.dart';

class CustomInputArea extends StatefulWidget {
  final Widget textField;
  final List<Widget>? prefixWidgets;
  final List<Widget>? suffixWidgets;
  final String? labelString;
  final double width;
  final double height;
  final Color? bgColor;
  final EdgeInsets margin;
  final EdgeInsets inputFieldPadding;
  final bool isExpanded;
  const CustomInputArea({
    Key? key,
    required this.textField,
    this.prefixWidgets,
    this.suffixWidgets,
    this.labelString,
    this.width = 366,
    this.height = 60,
    this.bgColor,
    this.isExpanded = false,
    this.margin = const EdgeInsets.symmetric(vertical: 12),
    this.inputFieldPadding = const EdgeInsets.symmetric(horizontal: 24),
  }) : super(key: key);

  @override
  State<CustomInputArea> createState() => _CustomInputAreaState();
}

class _CustomInputAreaState extends State<CustomInputArea> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final inputContainer = Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: Container(
        margin: widget.margin,
        height: widget.height,
        width: widget.isExpanded ? double.infinity : widget.width,
        decoration: BoxDecoration(
          color: widget.bgColor ?? (IColors.inputBgColor),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isFocused ? IColors.primary : IColors.inputBgColor),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: widget.prefixWidgets ?? []),
            ),
            Expanded(
                child: Padding(
              padding: widget.inputFieldPadding,
              child: widget.textField,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: widget.suffixWidgets ?? []),
            )
          ],
        ),
      ),
    );

    return inputContainer;
  }
}

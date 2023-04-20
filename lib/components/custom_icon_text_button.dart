import 'package:flutter/material.dart';

import '../core/theme/colors.style.dart';

enum IconPosition { left, right }

class CustomIconTextButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Color iconBgColor;
  final VoidCallback? onTap;
  final IconPosition iconPosition;
  const CustomIconTextButton({
    Key? key,
    required this.text,
    required this.icon,
    this.iconBgColor = IColors.primary,
    this.iconPosition = IconPosition.left,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cIcon = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconBgColor,
        shape: BoxShape.circle,
      ),
      child: icon,
    );
    final title = Text(
      text,
      style: const TextStyle(fontSize: 15),
    );
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: iconPosition == IconPosition.left
            ? [
                cIcon,
                const SizedBox(width: 16),
                title,
              ]
            : [
                title,
                const SizedBox(width: 16),
                cIcon,
              ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../core/theme/colors.style.dart';

class CoinLogoContainer extends StatelessWidget {
  final double? coinRadius;
  const CoinLogoContainer({
    Key? key,
    this.coinRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: IColors.primary.withOpacity(0.8),
        border: Border.all(color: IColors.primary),
        shape: BoxShape.circle,
      ),
      child: const Text(
        '\$',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

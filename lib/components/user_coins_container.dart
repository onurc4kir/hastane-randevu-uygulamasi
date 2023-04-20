import 'package:flutter/material.dart';

import 'coin_logo_container.dart';

class UserCoinsContainer extends StatelessWidget {
  final String coinAmount;
  const UserCoinsContainer({Key? key, required this.coinAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        child: Row(
          children: [
            const Spacer(),
            Expanded(child: Text(coinAmount)),
            const Expanded(child: CoinLogoContainer()),
          ],
        ),
      ),
    );
  }
}

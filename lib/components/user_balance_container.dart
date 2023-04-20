import 'package:flutter/material.dart';

class UserBalanceContainer extends StatelessWidget {
  final String balance;
  const UserBalanceContainer({Key? key, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wallet,
            color: Colors.black54,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            balance,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

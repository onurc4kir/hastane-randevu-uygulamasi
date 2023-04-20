import 'package:flutter/material.dart';

enum StatusType { danger, warning, success }

class StatusChipContainer extends StatelessWidget {
  final String status;
  final StatusType statusType;
  const StatusChipContainer({
    Key? key,
    required this.status,
    this.statusType = StatusType.success,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
      ),
    );
  }

  Color _getColor() {
    switch (statusType) {
      case StatusType.danger:
        return Colors.red.withOpacity(0.9);
      case StatusType.warning:
        return Colors.orange;
      case StatusType.success:
        return Colors.green;
    }
  }
}

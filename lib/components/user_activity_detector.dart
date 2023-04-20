import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:randevu_al/controllers/auth_controller.dart';

/// Tracks user activity based on tap/click event
class UserActivityDetector extends StatefulWidget {
  const UserActivityDetector({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<UserActivityDetector> createState() => _UserActivityDetectorState();
}

class _UserActivityDetectorState extends State<UserActivityDetector> {
  // Instance of Auto Logout Service, prefer using singleton
  late final AuthController _authController = Get.find<AuthController>();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    if (_authController.user != null) {
      _authController.startNewTimer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          _authController.trackUserActivity();
        }
      },
      child: GestureDetector(
        // Important for detecting the clicks properly for clickable and non-clickable places.
        behavior: HitTestBehavior.deferToChild,
        onTapDown: _authController.trackUserActivity,
        child: widget.child,
      ),
    );
  }
}

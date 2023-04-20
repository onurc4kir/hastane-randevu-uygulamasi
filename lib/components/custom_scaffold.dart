import 'dart:math';

import 'package:flutter/material.dart';

import 'custom_back_button.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color? bgColor;
  final String? title;
  final bool isShowBackButton;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry contentPadding;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color drawerScrimColor;
  final bool useSafeArea;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? trailing;
  final Widget? bottomNavigationBar;
  const CustomScaffold({
    Key? key,
    this.scaffoldKey,
    required this.body,
    this.bgColor,
    this.isShowBackButton = true,
    this.contentPadding = const EdgeInsets.all(12.0),
    this.title,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.drawerScrimColor = Colors.transparent,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.floatingActionButton,
    this.useSafeArea = true,
    this.bottomNavigationBar,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: contentPadding,
      child: Column(
        children: [
          Row(
            children: [
              if (isShowBackButton)
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: CustomBackButton(),
                ),
              if (title != null)
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          Expanded(child: body)
        ],
      ),
    );
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      key: scaffoldKey,
      appBar: appBar,
      backgroundColor: bgColor,
      drawerScrimColor: drawerScrimColor,
      drawer: drawer,
      endDrawer: endDrawer,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: min(MediaQuery.of(context).size.width, 600)),
          child: useSafeArea
              ? SafeArea(
                  child: content,
                )
              : content,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../core/utilities/asset_names.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Image.asset(AssetNames.logo,
          width: MediaQuery.of(context).size.width * 0.85),
    );
  }
}

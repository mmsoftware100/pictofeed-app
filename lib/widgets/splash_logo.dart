import 'package:flutter/material.dart';

class OBSplashLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/openbook-o-logo.png',
          height: 400.0,
          width: 280.0,
        ),
      ],
    );
  }
}

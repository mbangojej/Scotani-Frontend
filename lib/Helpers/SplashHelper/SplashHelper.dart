import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';

class SplashHelper {
  BuildContext context;

  SplashHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  Widget splash() {
    return Container(
      width: static.width,
      child: Stack(
        children: [
          Image.asset(
            'assets/Images/splashBackGround.png',
            fit: BoxFit.cover,
            width: static.width,
            height: static.height,
          ),
          Center(
            child: Lottie.asset(
              "assets/JSON/skincanvas.json",
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

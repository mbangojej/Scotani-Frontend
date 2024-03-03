// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/LoginAndSignupHelper.dart';

class LoginAndSignUpScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    LoginAndSignUpHelper helper = LoginAndSignUpHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: InternetConnectivityScreen(
              widget: SingleChildScrollView(
                child: Container(
                  width: static.width,
                  height: static.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),

                      ///
                      /// to Images
                      ///
                      helper.topImages(),

                      helper.logoText(),
                      helper.description(),
                      helper.header(),

                      helper.images(),
                    ],
                  ),
                  // child: Stack(
                  //   children: [
                  // helper.backGroundImage(),
                  // helper.image(),
                  //     // Positioned(
                  //     //   top: static.height * .345,
                  //     //   left: 0,
                  //     //   right: 0,
                  //     //   child: helper.circularTriangle(),
                  //     // ),
                  //     // Positioned(
                  //     //   top: static.height * .55,
                  //     //   left: 0,
                  //     //   right: 0,
                  //     //   child: helper.headingText(),
                  //     // ),
                  //     // Positioned(
                  //     //   bottom: 30.h,
                  //     //   child: Column(
                  //     //     children: [
                  // helper.loginButton(),
                  // helper.createAnAccountButton(),
                  //     //     ],
                  //     //   ),
                  //     // ),
                  //   ],
                  // )
                ),
              ),
            )),
      ),
    );
  }
}

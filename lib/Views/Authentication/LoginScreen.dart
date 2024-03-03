// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/LoginAndSignupHelper.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/LoginHelper.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/main.dart';

class LoginScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    LoginHelper helper = LoginHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return generalWatch.restrictUserNavigation == false
            ? await Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1500),
                    pageBuilder: (_, __, ___) => LoginAndSignUpScreen()))
            : false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          resizeToAvoidBottomInset: false,
          body: InternetConnectivityScreen(
            widget: Container(
                width: static.width,
                height: static.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      utils.statusBar(context,
                          color: themeColor.backGroundColor),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///
                      /// Logo
                      ///
                      Image.asset(
                        "assets/Icons/logo.png",
                        scale: 3.5,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        "assets/Icons/scotani_name.png",
                        scale: 3.5,
                      ),
                      helper.loginText(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          helper.fieldForEmail(),
                          helper.fieldForPassword(),
                          helper.RememberMe(),
                          helper.loginButton(),
                          helper.forgotPassword(),
                        ],
                      ),
                      helper.dontHaveAccountText(),
                      utils.bottomBar(context,
                          color: themeColor.backGroundColor),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

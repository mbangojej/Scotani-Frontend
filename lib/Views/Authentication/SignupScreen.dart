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
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/SignupHelper.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({required this.isFromLogin});

  bool isFromLogin = false;
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();
  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    SignUpHelper helper = SignUpHelper(context);

    return WillPopScope(
      onWillPop: () async {
        if (generalWatch.restrictUserNavigation == false) {
          authRead.selectedImageUpdation(file: null);
          authWatch.signupNameController.clear();
          authWatch.signupEmailController.clear();
          authWatch.signupMobileController.clear();
          authWatch.signupPasswordController.clear();
          authWatch.signupAddressController.clear();
          return await Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1500),
                  pageBuilder: (_, __, ___) =>
                      isFromLogin ? LoginScreen() : LoginAndSignUpScreen()));
        } else {
          return false;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          body: InternetConnectivityScreen(
            widget: Container(
                width: static.width,
                height: static.height,
                child: Column(
                  children: [
                    utils.statusBar(context, color: themeColor.backGroundColor),
                    helper.signUpText(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            helper.cameraWidget(),
                            SizedBox(
                              height: 10.h,
                            ),
                            helper.fieldForFullName(),
                            helper.fieldForEmail(),
                            helper.fieldForMobile(),
                            helper.fieldForPassword(),
                            helper.fieldForAddress(),
                            helper.signUpButton(),
                            helper.alreadyHaveAccountText(),
                          ],
                        ),
                      ),
                    ),
                    utils.bottomBar(context, color: themeColor.backGroundColor),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

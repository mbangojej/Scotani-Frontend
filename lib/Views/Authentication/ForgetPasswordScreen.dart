// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/ForgetPasswordHelper.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/main.dart';

import '../../AppUtils/InternetConnectivity.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordHelper helper = ForgetPasswordHelper(context);

    return WillPopScope(
      onWillPop: () async {
        if (generalWatch.restrictUserNavigation == false) {
          authWatch.forgetPasswordController.clear();
          return await Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 1500),
                  pageBuilder: (_, __, ___) => LoginScreen()));
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
                    helper.forgetPasswordText(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                            ),
                            helper.fieldForEmail(),
                            helper.sendButton(),
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

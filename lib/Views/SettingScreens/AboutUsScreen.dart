import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/SignupHelper.dart';
import 'package:skincanvas/Helpers/SettingHelper/AboutUsHelper.dart';
import 'package:skincanvas/Helpers/SettingHelper/EditProfileHelper.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';

class AboutUsScreen extends StatelessWidget {

  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    AboutUsHelper helper = AboutUsHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
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
                    helper.aboutUsText(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            helper.aboutUsDetail(),
                            SizedBox(
                              height: 30.h,
                            ),

                          ],
                        ),
                      ),
                    ),

                    helper.contactUsLabel(),
                    helper.contactUsInfo(),

                    SizedBox(
                      height: 10.h,
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

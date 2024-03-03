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
import 'package:skincanvas/Helpers/AuthenticationHelper/ResetPasswordHelper.dart';
import 'package:skincanvas/main.dart';

class ResetPasswordScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();


  var generalWatch = Provider.of<GeneralController>(navigatorkey.currentContext!, listen: false);

  @override
  Widget build(BuildContext context) {
    ResetPasswordHelper helper = ResetPasswordHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return generalWatch.restrictUserNavigation == false ? true : false;
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
                    helper.resetPasswordText(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            helper.fieldForNewPassword(),
                            helper.fieldForConfirmPassword(),
                            helper.submitButton(),
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

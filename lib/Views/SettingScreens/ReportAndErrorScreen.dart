import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Helpers/SettingHelper/ReportAndErrorHelper.dart';

class ReportAndErrorScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    ReportAndErrorHelper helper = ReportAndErrorHelper(context);

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
                  helper.reportAndErrorText(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          helper.fieldForFullName(),
                          helper.fieldForEmail(),
                          helper.fieldForPhone(),
                          helper.fieldForSubject(),
                          helper.fieldForMessage(),
                          helper.sendButton(),
                        ],
                      ),
                    ),
                  ),
                  utils.bottomBar(context, color: themeColor.backGroundColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

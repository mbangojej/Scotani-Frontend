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
import 'package:skincanvas/Helpers/SettingHelper/FAQHelper.dart';
import 'package:skincanvas/main.dart';

class FAQScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();

  @override
  Widget build(BuildContext context) {
    FAQHelper helper = FAQHelper(context);

    return WillPopScope(
      onWillPop: () async {
        generalWatch.faqController.clear();
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
                    helper.faqText(),
                    helper.fieldForSearch(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            helper.faqStatements(),
                            // helper.aboutPaymentText(),
                            // helper.faqOrderPaymentStatements(),
                          ],
                        ),
                      ),
                    ),

                    // helper.contactUsLabel(),
                    // helper.contactUsInfo(),

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

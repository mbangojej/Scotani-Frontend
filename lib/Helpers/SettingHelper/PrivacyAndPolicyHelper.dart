import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class PrivacyAndPolicyHelper {
  BuildContext context;

  PrivacyAndPolicyHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget privacyAndPolicyText() {
    final plainText =
        utils.convertHtmlToPlainText(generalWatch.privacyAndPolicyData);

    return Container(
      width: static.width,
      child: Column(
        children: [
          utils.appBar(
            context,
            barText: 'Privacy Policy',
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w) +
                      EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    "$plainText",
                    style: utils.labelStyle(
                      theme.whiteColor.withOpacity(.7),
                    ),
                    textAlign: TextAlign.justify,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

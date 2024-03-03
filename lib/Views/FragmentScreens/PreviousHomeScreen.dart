import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Helpers/FragmentHelpers/PreviousHomeScreen.dart';

class PreviousHomeScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    PreviousHomeHelper helper = PreviousHomeHelper(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: themeColor.backGroundColor,
        body: Container(
          width: static.width,
          height: static.height,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              helper.welcomeText(),
              helper.fieldForSearch(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      helper.inspirationsHeadingText(),
                      helper.InspirationalWidgets(),
                      helper.discoverDesign(),
                      helper.featureDesign(),
                      helper.otherProductDesign(),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

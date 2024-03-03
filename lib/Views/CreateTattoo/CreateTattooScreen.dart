import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Helpers/CreateTattooHelper/CreateTattooHelper.dart';
import 'package:skincanvas/Views/FragmentScreens/BottomNavigationBar.dart';
import 'package:skincanvas/main.dart';

class CreateTattooScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    CreateTattooHelper helper = CreateTattooHelper(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (generalWatch.restrictUserNavigation == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigation(),
                ));
          }
          return generalWatch.restrictUserNavigation == false ? true : false;
        },
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          resizeToAvoidBottomInset: false,
          body: InternetConnectivityScreen(
            widget: Container(
              width: static.width,
              height: static.height,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      utils.statusBar(context,
                          color: themeColor.backGroundColor),
                      helper.createYourTattooText(),
                      helper.designPrompt(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              helper.selectBodyArea(),
                              helper.selectDesignColor(),
                            ],
                          ),
                        ),
                      ),
                      helper.createTattooButton(),
                      utils.bottomBar(context,
                          color: themeColor.backGroundColor),
                    ],
                  ),
                  homeWatch.isCreatingGraphic
                      ? Container(
                          height: static.height,
                          width: static.width,
                          color: themeColor.blackColor.withOpacity(.4),
                        )
                      : SizedBox(),
                  homeWatch.isCreatingGraphic
                      ? Center(
                          child: Container(
                            height: static.width > 500
                                ? static.height * .60
                                : static.height * .74,
                            width: static.width > 500
                                ? static.width * .60
                                : static.width * .74,
                            decoration: BoxDecoration(
                                color: themeColor.whiteColor,
                                shape: BoxShape.circle),
                          ),
                        )
                      : SizedBox(),
                  homeWatch.isCreatingGraphic
                      ? Positioned(
                          left: static.width > 500 ? 70.w : 60.w,
                          top: 215.h,
                          child: Center(
                            child: Lottie.asset(
                              'assets/JSON/tattooAndProductLottie.json',
                              height: 185.h,
                              width: 185.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : SizedBox(),
                  homeWatch.isCreatingGraphic
                      ? Positioned(
                          left: static.width > 500 ? 140.w : 125.w,
                          bottom: static.width > 500 ? 215.h : 245.h,
                          child: Text(
                            'Magic Happening...',
                            style:
                                utils.labelStyleB(themeColor.midLightGreyColor),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

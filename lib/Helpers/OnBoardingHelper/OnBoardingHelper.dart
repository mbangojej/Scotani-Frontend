import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'dart:io' as io;
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/WidgetUpAnimation.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';
import '../../Models/MDOnBoadingContentModel.dart';

class OnBoardingHelper {
  BuildContext context;

  OnBoardingHelper(this.context) {
    SharedPreferences.getInstance().then((sharedPrefInstance) {
      myPrefs = sharedPrefInstance;
    });
  }

  SharedPreferences? myPrefs;

  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();
  var routes = Routes();

  Timer? _timer;

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget buildDots({
    int? index,
  }) {
    return generalWatch.currentPage == index
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: themeColor.orangeColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 5.w),
            padding: EdgeInsets.all(10),
            height: 6.h,
            curve: Curves.easeIn,
            width: 6.w,
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: themeColor.whiteColor.withOpacity(0.7),
                shape: BoxShape.circle),
            margin: EdgeInsets.only(right: 5.w),
            height: 6.h,
            curve: Curves.easeIn,
            // width: _currentPage == index ? 20 : 10,
            width: 6.w,
          );
  }

  Widget onBoardingPages(_controller) {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (generalWatch.currentPage <
          generalWatch.mdOnBoardingModal.splashData!.length - 1) {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
    return GestureDetector(
      onPanDown: (_) {
        _timer?.cancel();
      },
      child: Container(
        height: static.height,
        width: static.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/splashBackGround.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              onPageChanged: (value) =>
                  generalRead.onBoardingPageUpdate(index: value),
              itemCount: generalWatch.mdOnBoardingModal.splashData!.length,
              itemBuilder: (context, i) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      generalWatch.mdOnBoardingModal.splashData![i].image
                          .toString(),
                      height: static.height,
                      width: static.width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: static.height,
                      width: static.width,
                      decoration: BoxDecoration(
                        color: themeColor.blackColor.withOpacity(.9),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/Images/App_Name.png',
                        width: static.width * 0.6,
                      ),
                      top: 50.h,
                    ),
                    i > 0
                        ? Positioned(
                            child: Text(
                              'WELCOME TO',
                              style: utils.generalHeading(
                                  themeColor.whiteColor.withOpacity(.8),
                                  size: 43.sp,
                                  fontFamily: 'bebasLight'),
                            ),
                            top: 120.h,
                          )
                        : Positioned(
                            child: WidgetUpAnimation(
                              child: Text(
                                'WELCOME TO',
                                style: utils.generalHeading(
                                    themeColor.whiteColor.withOpacity(.8),
                                    size: static.width > 550 ? 38.sp : 43.sp,
                                    fontFamily: 'bebasLight'),
                              ),
                              top_to_bottom: true,
                              height: 100.0,
                              // The distance the widget will move during animation
                              duration: Duration(milliseconds: 1500),
                            ),
                            top: 120.h,
                          ),
                    i > 0
                        ? Positioned(
                            child: Text(
                              'SCOTANI',
                              style: utils.generalHeadingBold(
                                  themeColor.whiteColor,
                                  size: static.width > 550 ? 50.sp : 55.sp,
                                  fontFamily: 'Bebas'),
                            ),
                            top: 170.h,
                          )
                        : Positioned(
                            child: WidgetUpAnimation(
                              child: Text(
                                'SCOTANI',
                                style: utils.generalHeadingBold(
                                    themeColor.whiteColor,
                                    size: 55.sp,
                                    fontFamily: 'Bebas'),
                              ),
                              top_to_bottom: true,
                              height: 100.0,
                              // The distance the widget will move during animation
                              duration: Duration(milliseconds: 1500),
                            ),
                            top: 170.h,
                          ),
                    WidgetUpAnimation(
                      child: Container(
                        width: static.width * .75,
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(
                          generalWatch.mdOnBoardingModal.splashData![i].text
                              .toString(),
                          style: utils.xHeadingStyle(
                              themeColor.whiteColor.withOpacity(.8)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      top_to_bottom: false,
                      height: 80.h,
                    )
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  skipButton(_controller, index: generalWatch.currentPage),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      generalWatch.mdOnBoardingModal.splashData!.length,
                      (int index) => buildDots(
                        index: index,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget skipButton(_controller, {index = 0}) {
    return Padding(
      padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
          top: index == 2 ? 15.h : 25.h,
          bottom: io.Platform.isAndroid ? 0.h : 30.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.r),
            color: themeColor.orangeColor),
        width: static.width * 0.4,
        child: ElevatedButton(
          onPressed: () {
            // _controller.jumpToPage(2);
            // if (index == 2) {

            myPrefs!.setBool(static.isFirstTime, true);

            Navigator.pushNamed(context, routes.loginAndSignUpRoute);

            // }
          },
          child: Text(
            "Skip",
            style: utils.headingStyleB(
              themeColor.whiteColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColor.orangeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
      ),
    );
  }
}

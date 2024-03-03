//
// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:skincanvas/AppConstant/Routes.dart';
// import 'package:skincanvas/AppConstant/Static.dart';
// import 'package:skincanvas/AppConstant/Theme.dart';
// import 'package:skincanvas/AppUtils/AppUtils.dart';
// import 'package:skincanvas/Helpers/SplashHelper/SplashHelper.dart';
// import 'package:skincanvas/Views/Onboarding/OnboardingScreen.dart';
// import 'package:skincanvas/main.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   var routes = Routes();
//   var static = Statics();
//
//   Timer? timer;
//
//
//   double _animationOffsetY = 0.0;
//   double _maxAnimationOffsetY = - Statics().height* .3; // Maximum offset to avoid moving off-screen;
//
//   @override
//   void initState() {
//     // TODO: implement initStat
//
//      getFCMToken();
//
//    // timer = Timer(Duration(seconds: 5), () => getDataFromApis());
//
//
//     timer = Timer.periodic(Duration(milliseconds: 5000), (timer) {
//       if (_animationOffsetY > _maxAnimationOffsetY) {
//         setState(() {
//           _animationOffsetY -= 80.0.h; // Decrease the offset gradually
//         });
//       } else {
//         timer.cancel(); // Stop the timer when animation is complete
//       }
//     });
//
//
//     timer = Timer(Duration(milliseconds: 5500), () {
//       getDataFromApis();
//     });
//
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//
//     timer!.cancel();
//     super.dispose();
//   }
//
//   var themeColor = ThemeColors();
//   var utils = AppUtils();
//
//   @override
//   Widget build(BuildContext context) {
//     SplashHelper helper = SplashHelper(context);
//
//     return Scaffold(
//       backgroundColor: themeColor.backGroundColor,
//       body: Column(
//         children: [
//           utils.statusBar(context, color: themeColor.lightBlackColor),
//
//
//
//           // Expanded(
//           //   child: Container(
//           //     height: MediaQuery.of(context).size.height,
//           //     width: MediaQuery.of(context).size.width,
//           //     color: themeColor.backGroundColor,
//           //     child: Center(
//           //       child: AnimatedContainer(
//           //         duration: Duration(seconds: 1),
//           //         alignment: _isAnimationDone
//           //             ? Alignment.topCenter
//           //             : Alignment.center,
//           //         child: Lottie.asset(
//           //           "assets/JSON/skincanvassimple.json",
//           //           // Adjust other Lottie properties as needed
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//
//
//           Expanded(
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               color: themeColor.backGroundColor,
//               child: Center(
//                 child: Transform.translate(
//                   offset: Offset(0.0, _animationOffsetY),
//                   child: helper.splash(),
//                 ),
//               ),
//             ),
//           ),
//
//           utils.bottomBar(context, color: themeColor.midBlackColor),
//         ],
//       ),
//     );
//   }
//
//   getFCMToken() async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     FirebaseMessaging firebaseMessaging;
//     firebaseMessaging = FirebaseMessaging.instance;
//     String? firebaseToken = await firebaseMessaging.getToken();
//     print("FCM Token:" + " " + firebaseToken!);
//    // prefs.setString(static.fcmToken, firebaseToken);
//    // authRead.saveFCM(context, FcmToken: firebaseToken);
//   }
//
//   getRoute() async {
//     SharedPreferences? myPrefs = await SharedPreferences.getInstance();
//
//     tokenValue = (await myPrefs.get(static.token));
//     print('Token' + tokenValue.toString());
//
//     Navigator.pushNamed(context, routes.loginAndSignUpRoute);
//   }
//
//   getDataFromApis() async {
//     SharedPreferences myPrefs = await SharedPreferences.getInstance();
//     // Navigator.pushNamed(context, routes.onBoardingRoute);
//
//     //
//     // Navigator.push(
//     //     context,
//     //     PageRouteBuilder(
//     //         transitionDuration: Duration(milliseconds: 1500),
//     //         pageBuilder: (_, __, ___) => OnBoardingScreen()));
//
//     //await getRoute();
//   }
// }

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Helpers/SplashHelper/SplashHelper.dart';
import 'package:skincanvas/Views/Onboarding/OnboardingScreen.dart';
import 'package:skincanvas/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var routes = Routes();
  var static = Statics();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  late AnimationController motionController;
  late Animation motionAnimation;

  double size = 0.6.sw;
  int animationForwardCount = 0;

  @override
  void initState() {
    super.initState();

    getFCMToken();

    motionController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.5,
    );
    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (animationForwardCount < 2) {
          // Forward animation twice
          animationForwardCount++;
          motionController.reverse();
        } else {
          // Reverse animation after running forward twice
          // motionController.reverse();
          getDataFromApis(); // Call your function here
        }
      } else if (status == AnimationStatus.dismissed) {
        motionController.forward();
      }
    });
    motionController.addListener(() {
      setState(() {
        size = motionController.value * 250;
      });
    });
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  var themeColor = ThemeColors();
  var utils = AppUtils();

  @override
  Widget build(BuildContext context) {
    SplashHelper helper = SplashHelper(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: themeColor.backGroundColor,
        body: Column(
          children: [
            utils.statusBar(context, color: themeColor.backGroundColor),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: themeColor.backGroundColor,
                margin: EdgeInsets.only(top: 40.h),
                child: Center(
                  child: Image.asset(
                    "assets/Icons/scotani_name.png",
                    height: size,
                    // Use .sw instead of .w for width-based sizing
                    width: size,
                    // Use .sw instead of .w for width-based sizing
                    fit: BoxFit.contain,
                  ),
                  // AnimatedBuilder(
                  //   animation: _animation,
                  //   builder: (context, child) {
                  //     return Transform.translate(
                  //       offset: Offset(0.0, _animation.value),
                  //       child:
                  //       Lottie.asset(
                  //         "assets/JSON/skincanvassimple.json",
                  //         // Adjust other Lottie properties as needed
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ),
            ),
            utils.bottomBar(context, color: themeColor.backGroundColor),
          ],
        ),
      ),
    );
  }

  getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging firebaseMessaging;
    firebaseMessaging = FirebaseMessaging.instance;
    // String? firebaseToken = await firebaseMessaging.getToken() == null
    //     ? ''
    //     : firebaseMessaging.getToken() as String;
    String? firebaseToken = await firebaseMessaging.getToken();
    if (firebaseToken == null) {
      firebaseToken = ''; // Set a default value if it's null
    }
    print("FCM Token:" + " " + firebaseToken);
    prefs.setString(static.fcmToken, firebaseToken);
    //String? firebaseToken = await firebaseMessaging.getToken() == null ?'': firebaseMessaging.getToken() as String;
    //print("FCM Token:" + " " + firebaseToken);
    // prefs.setString(static.fcmToken, firebaseToken);
  }

  getDataFromApis() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    fcmTokenValue = (await myPrefs.get(static.fcmToken)) as String?;
    userToken = await (myPrefs.get(static.userToken)) == null
        ? ''
        : (myPrefs.get(static.userToken)) as String;
    userID = await myPrefs.get(static.userID) == null
        ? ""
        : myPrefs.get(static.userID) as String;

    // bool isCouponApply = (await (myPrefs.getBool(static.canCouponApply)) == null  ? true : (myPrefs.getBool(static.canCouponApply)))!;

    // await navigatorkey.currentContext!.read<OrderCheckOutWishlistController>().canCouponApplyUpdate(value:isCouponApply );

    await navigatorkey.currentContext!
        .read<GeneralController>()
        .fetchingUserStaticData();

    rememberEmail = (await myPrefs.get(static.isRememberEmail)) == null
        ? ""
        : (await myPrefs.get(static.isRememberEmail)) as String?;
    rememberPassword = (await myPrefs.get(static.isRememberPassword)) == null
        ? ""
        : (await myPrefs.get(static.isRememberPassword)) as String?;
    rememberStatus = (await myPrefs.get(static.isRememberStatus)) == null
        ? false
        : (await myPrefs.get(static.isRememberStatus)) as bool?;
    firstTimeValue = (await myPrefs.get(static.isFirstTime)) == null
        ? false
        : (await myPrefs.get(static.isFirstTime)) as bool?;

    // couponCode = ((await myPrefs.get(static.discountCouponString)) == null ? ""
    //     : (await myPrefs.get(static.discountCouponString)) as String?)!;

    print("Getting firstTime Value is:" + firstTimeValue!.toString());
    print("Getting User Token Value is:" + userToken.toString());
    print("Getting User ID Value is:" + userID.toString());

    await navigatorkey.currentContext!
        .read<AuthenticationController>()
        .rememberMeUpdator(
            value: rememberStatus ?? false,
            email: rememberEmail ?? '',
            password: rememberPassword ?? '');

    await getRoute();
  }

  getRoute() async {
    // if (firstTimeValue == true && userToken.isEmpty && userID.isEmpty) {
    //   Navigator.pushNamed(context, routes.loginAndSignUpRoute);
    // }

    if (firstTimeValue == true &&
        userToken.isNotEmpty &&
        userID.isNotEmpty &&
        generalWatch.isEmailVerified == 0) {
      Navigator.pushNamed(context, routes.loginScreenRoute);
    } else if (firstTimeValue == true &&
        userToken.isNotEmpty &&
        userID.isNotEmpty &&
        generalWatch.isEmailVerified == 1) {
      Navigator.pushNamed(context, routes.bottomNavigationScreenRoute);
    } else {
      Navigator.pushNamed(context, routes.loginAndSignUpRoute);
      // await navigatorkey.currentContext!
      //     .read<GeneralController>()
      //     .onBoardingApi(context);

      // Navigator.push(
      //     context,
      //     PageRouteBuilder(
      //         transitionDuration: Duration(milliseconds: 1500),
      //         pageBuilder: (_, __, ___) => OnBoardingScreen()));
    }
  }
}

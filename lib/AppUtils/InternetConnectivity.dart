import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';

class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  CheckInternetConnectionWidget(
      {Key? key, required this.snapshot, required this.widget})
      : super(key: key);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Container(
              height: static.height,
              width: static.width,
              color: theme.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/JSON/noInternet.json',
                      height: Statics().width > 550 ? 80.h : 110.h,
                      width: Statics().width > 550 ? 80.w : 110.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Uh-Oh!',
                    style: utils.headingStyleB(theme.blackColor),
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    'Slow or no internet connection',
                    style: utils.generalHeading(theme.midLightGreyColor,size: 15.sp),
                  ),
                  Text(
                    'Please check your internet settings and try again',
                    style: utils.generalHeading(theme.midLightGreyColor,size: 15.sp),
                  ),
                ],
              ),
            );
          default:
            return widget;
        }
        break;
      default:
        return widget;
    }
  }
}

class InternetConnectivityScreen extends StatefulWidget {
  final Widget widget;
  InternetConnectivityScreen({required this.widget});

  @override
  State<InternetConnectivityScreen> createState() =>
      _InternetConnectivityScreenState();
}

class _InternetConnectivityScreenState
    extends State<InternetConnectivityScreen> {
  List<Color> colors = [
    Colors.redAccent,
    Colors.purple,
    Colors.pinkAccent,
    Colors.black,
    Colors.teal,
    Colors.green,
    Colors.grey
  ];

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return StreamBuilder<ConnectivityResult>(
      stream: connectivity.onConnectivityChanged,
      builder: (_, snapshot) {
        return CheckInternetConnectionWidget(
          snapshot: snapshot,
          widget: widget.widget,
        );
      },
    );
  }
}

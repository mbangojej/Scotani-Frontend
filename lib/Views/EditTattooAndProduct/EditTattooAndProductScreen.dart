import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Helpers/EditTattooAndProductHelper/EditTattooAndProductHelper.dart';
import 'package:skincanvas/main.dart';

class EditTattooAndProductScreen extends StatefulWidget {
  @override
  State<EditTattooAndProductScreen> createState() =>
      _EditTattooAndProductScreenState();
}

class _EditTattooAndProductScreenState
    extends State<EditTattooAndProductScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  @override
  Widget build(BuildContext context) {
    EditTattooAndProductHelper helper =
        EditTattooAndProductHelper(context, screenshotController);

    return WillPopScope(
      onWillPop: () async {
        if (generalWatch.restrictUserNavigation == false) {
          homeRead.updateIsIncreaseTextSize(value: false);
          if (homeWatch.imagePreview) {
            homeRead.updateImagePreview();
          }
          return homeWatch.imagePreview ? false : true;
        } else {
          return false;
        }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  helper.topBar(),
                  helper.imageView(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          helper.setColorAndSize(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

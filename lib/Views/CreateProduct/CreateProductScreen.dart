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
import 'package:skincanvas/Helpers/AddToWishListHelper/FavouriteProductHelper.dart';
import 'package:skincanvas/Helpers/CreateProductHelper/CreateProductHelper.dart';
import 'package:skincanvas/Helpers/PlaceOrderHelper/OrderDetailHelper.dart';
import 'package:skincanvas/main.dart';

class CreateProductScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var homeRead = navigatorkey.currentContext!.read<HomeController>();
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    CreateProductHelper helper = CreateProductHelper(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (generalWatch.restrictUserNavigation == false) {
            homeRead.updateIsShowGraphicsContainer(isBackButton: true);
            homeRead.categoryStatusUpdate(
                index: homeWatch.selectedcategorystatusindex);
            return true;
          } else {
            return false;
          }
        },
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          resizeToAvoidBottomInset: true,
          body: InternetConnectivityScreen(
            widget: Container(
              width: static.width,
              height: static.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      utils.statusBar(context,
                          color: themeColor.backGroundColor),
                      helper.topBar(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: static.width,
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                helper.showProduct(),
                                helper.textFields(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: helper.nextButton(),
                      ),
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

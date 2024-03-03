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
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Helpers/Cart&CheckoutHelper/MyCartHelper.dart';
import 'package:skincanvas/main.dart';

class MyCartScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    MyCartHelper helper = MyCartHelper(context);

    var orderWatch =
        navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();

    var generalWatch = Provider.of<GeneralController>(
        navigatorkey.currentContext!,
        listen: false);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return orderWatch.onCartFromHome
              ? generalWatch.restrictUserNavigation == false
                  ? true
                  : false
              : false;
        },
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          body: InternetConnectivityScreen(
            widget: Container(
              width: static.width,
              height: static.height,
              child: Column(
                children: [
                  utils.statusBar(context, color: themeColor.backGroundColor),
                  helper.selectCategoryText(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          helper.myCartList(),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  helper.totalAmountWidget(),
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

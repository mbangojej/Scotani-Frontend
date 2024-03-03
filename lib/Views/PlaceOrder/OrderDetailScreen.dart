import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Helpers/AddToWishListHelper/FavouriteProductHelper.dart';
import 'package:skincanvas/Helpers/PlaceOrderHelper/OrderDetailHelper.dart';

class OrderDetailScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    OrderDetailHelper helper = OrderDetailHelper(context);

    return Scaffold(
      backgroundColor: themeColor.backGroundColor,
      body: InternetConnectivityScreen(
        widget: Container(
          width: static.width,
          height: static.height,
          child: Column(
            children: [
              utils.statusBar(context, color: themeColor.backGroundColor),
              helper.MyWishListText(),
              helper.myCartList(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      helper.description(),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
              helper.priceOfOrder(),
              utils.bottomBar(context, color: themeColor.backGroundColor),
            ],
          ),
        ),
      ),
    );
  }
}

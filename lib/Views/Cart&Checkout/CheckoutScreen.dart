import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/Cart&CheckoutHelper/CheckoutHelper.dart';
import 'package:skincanvas/Helpers/Cart&CheckoutHelper/MyCartHelper.dart';

import '../../Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import '../../main.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var themeColor = ThemeColors();

  var utils = AppUtils();

  var static = Statics();
  var orderAndCheckOutRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();

  //

  couponFunction() async {
    // SharedPreferences myPrefs = await SharedPreferences.getInstance();
    // couponCode = (await myPrefs.get(static.discountCouponString) == null
    //     ? ""
    //     : (await myPrefs.get(static.discountCouponString)) as String?)!;
    //
    // print('discountCouponString $couponCode');
    //
    // if (couponCode != '') {
    //   orderAndCheckOutRead.couponCodeController.text = couponCode;
    //   await orderAndCheckOutRead.validateCoupanApi(context);
    // } else {
    orderAndCheckOutRead.couponCodeController.clear();
    orderAndCheckOutRead.canCouponApplyUpdate(value: false);
    orderAndCheckOutRead.discountAmountUpdate(value: 0.0);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      couponFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckOutHelper helper = CheckOutHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return generalWatch.restrictUserNavigation == false ? true : false;
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
                children: [
                  utils.statusBar(context, color: themeColor.backGroundColor),
                  helper.selectCategoryText(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          helper.nameAndAddressWidget(),
                          helper.paymentMethodWidget(),
                          helper.coupanFieldWidget(),
                          helper.priceWidgets(),
                          SizedBox(
                            height: 20.h,
                          ),
                          helper.placeOrderButton(),
                        ],
                      ),
                    ),
                  ),
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

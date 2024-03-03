import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Views/FragmentScreens/BottomNavigationBar.dart';
import 'package:skincanvas/main.dart';

class SuccessfulOrderBottomSheet {
  var static = Statics();
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var route = Routes();

  var homRead = navigatorkey.currentContext!.read<HomeController>();
  var orderRead = Provider.of<OrderCheckOutWishlistController>(navigatorkey.currentContext!, listen: false);

  sheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: themeColor.transparentColor,
        isScrollControlled: true,
        isDismissible: false, // Add this line to prevent dismissal
        builder: (builder) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return WillPopScope(
              onWillPop: () async {
                // Returning false here will prevent the BottomSheet from closing
                return false;
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  child: Container(
                    height: static.height * 0.74,
                    width: static.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0.r),
                        topLeft: Radius.circular(16.0.r),
                      ),
                      color: themeColor.whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0.h) +
                          EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: Container(
                          //       alignment: Alignment.centerRight,
                          //       child: Image.asset(
                          //         'assets/Icons/xMark.png',
                          //         height: static.width > 550 ? 12.sp : 18.h,
                          //         width: static.width > 550 ? 12.sp : 18.w,
                          //         color: themeColor.greyColor,
                          //       )),
                          // ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Lottie.asset(
                                  'assets/JSON/placeOrderCelebration.json',
                                  height: static.width > 550 ? 130.h : 175.h,
                                  width: static.width > 550 ? 130.w : 230.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  height: static.width > 550 ? 80.h : 110.h,
                                  width: static.width > 550 ? 80.w : 110.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF4F4F4),
                                  ),
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/JSON/placeOrder.json',
                                      height: static.width > 550 ? 80.h : 110.h,
                                      width: static.width > 550 ? 80.w : 110.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Thank You!',
                                          style: utils.generalHeading(
                                            themeColor.blackColor,
                                            fontFamily: 'finalBold',
                                            size: static.width > 550
                                                ? 20.sp
                                                : 30.sp,
                                          ),
                                        ),
                                        Text(
                                          'for your order',
                                          style: utils.xHeadingStyle(
                                            themeColor.blackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          'Your Order is now being processed. We will let you know once the order will be ready. Check the status of your order any time.',
                                          style: utils.labelStyle(
                                            themeColor.blackColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    width: static.width,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 18.h),
                                    child: utils.button(
                                      textSize:
                                          static.width > 550 ? 10.sp : 20.sp,
                                      text: "Track My Order",
                                      buttonColor: themeColor.orangeColor,
                                      borderColor: themeColor.orangeColor,
                                      fontFamily: 'finalBold',
                                      ontap: () async {
                                        await orderRead.orderStatusUpdate(
                                            status: '0',
                                            ID: orderRead.orderID.toString(),
                                            backToNavigate: false);

                                        Navigator.pushNamed(
                                            context,
                                            route
                                                .orderHistoryStatusScreenRoute);
                                      },
                                      textColor: themeColor.whiteColor,
                                      width: static.width,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h) +
                                            EdgeInsets.only(bottom: 10.h),
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      onPressed: () {
                                        orderRead.orderListingApi(context,
                                            isLoading: true, searching: '');
                                        homRead.screenIndexUpdate(index: 1);
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigation()), (Route<dynamic> route) => false,  // This ensures no previous routes are left in the stack
                                        );
                                        // Navigator.pushNamed(context,
                                        //     route.bottomNavigationScreenRoute);
                                      },
                                      child: Text(
                                        'View Order',
                                        style: utils.labelStyle(
                                            themeColor.blackColor,
                                            fontFamily: 'finalBold'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        }).whenComplete(() => sheet(context));
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDPaypal.dart';
import 'package:skincanvas/PaymentMethods/GpayAndApplePay.dart';
import 'package:skincanvas/PaymentMethods/WebviewPapayl.dart';
import 'package:skincanvas/PaymentMethods/stripe.dart';
import 'dart:io' show Platform;
import 'package:skincanvas/main.dart';

class CheckOutHelper {
  BuildContext context;

  CheckOutHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var orderAndCheckOutWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderAndCheckOutRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget selectCategoryText() {
    return utils.appBar(context, barText: 'Checkout', onPress: () {
      orderAndCheckOutWatch.couponCodeController.clear();
      orderAndCheckOutWatch.updateSubtotal(isFromRemove: true);
      orderAndCheckOutWatch.canCouponApplyUpdate(value: false);
      Navigator.pop(context);
    });
  }

  nameAndAddressWidget() {
    return Consumer<GeneralController>(builder: (context, generalWatch, _) {
      return Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(top: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${generalWatch.fullNameValue}',
              style: utils.headingStyleB(theme.orangeColor,
                  fontFamily: 'finalBold'),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 16.sp,
                  color: theme.whiteColor,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Location',
                  style: utils.labelStyle(theme.whiteColor,
                      fontFamily: 'finalBook'),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: static.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      width: static.width * .45,
                      child: Text(
                        '${generalWatch.addressValue}',
                        style: utils.labelStyle(
                            theme.whiteColor.withOpacity(.5),
                            fontFamily: 'finalBold'),
                      )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      generalWatch.editNameController.text =
                          generalWatch.fullNameValue!;
                      generalWatch.editEmailController.text =
                          generalWatch.emailValue!;
                      generalWatch.editMobileController.text =
                          generalWatch.phoneValue!;
                      generalWatch.editAddressController.text =
                          generalWatch.addressValue!;
                      generalRead.selectedImageUpdation(
                          string: generalWatch.profilePhotoValue);

                      Navigator.pushNamed(
                          context, route.editProfileScreenRoute);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Change',
                          style: utils.labelStyle(theme.redColor,
                              fontFamily: 'finalBold'),
                        )),
                  )),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  paymentMethodWidget() {
    // return Consumer<OrderCheckOutWishlistController>(
    //     builder: (context, orderAndWishListWatch, _) {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(
        vertical: 15.h,
      ),
      decoration: BoxDecoration(color: theme.lightBlackColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style:
                    utils.labelStyle(theme.whiteColor, fontFamily: 'finalBook'),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          paymentMethodSelectionContainer(
              onTap: () {
                orderAndCheckOutRead.updateRadioButton(stripePay: true);
              },
              image: 'stripe',
              status: orderAndCheckOutWatch.stripe),
          // SizedBox(
          //   height: 8.h,
          // ),
          // paymentMethodSelectionContainer(
          //     onTap: () {
          //       orderAndCheckOutRead.updateRadioButton(googlePay: true);
          //     },
          //     image: Platform.isAndroid ? 'googlePay' : 'applePay',
          //     status: orderAndWishListWatch.googleAndApplePay),
          SizedBox(
            height: 8.h,
          ),
          paymentMethodSelectionContainer(
              onTap: () {
                orderAndCheckOutRead.updateRadioButton(paypal: true);
              },
              image: 'paypal',
              status: orderAndCheckOutWatch.payPal),
        ],
      ),
    );
    // });
  }

  priceWidgets() {
    return Consumer<OrderCheckOutWishlistController>(
        builder: (context, orderAndCheckOutWatch, _) {
      return Container(
        child: Column(
          children: [
            pricesContainer(
                heading: 'Sub Total',
                price: orderAndCheckOutWatch.isFromOrderDetail
                    ? (orderAndCheckOutWatch
                        .mdOrderDetailModal.order!.first.orderPrice!)
                    : '${orderAndCheckOutWatch.mdCartModal.cart!.first.subTotal! + (orderAndCheckOutWatch.discountAmount != 0.0 ? orderAndCheckOutWatch.discountAmount : 0.0)}',
                isTotal: false),
            // SizedBox(
            //   height: 20.h,
            // ),
            // pricesContainer(
            //     heading: 'Service Cost', price: '1.0', isTotal: false),
            SizedBox(
              height: 20.h,
            ),
            pricesContainer(
                heading: 'Discount',
                price: '${orderAndCheckOutWatch.discountAmount}',
                isTotal: false),
            SizedBox(
              height: 20.h,
            ),
            pricesContainer(
                heading: 'Total',
                price:
                    '${orderAndCheckOutWatch.isFromOrderDetail ? (orderAndCheckOutWatch.mdOrderDetailModal.order!.first.orderPrice!.toDouble()) : (orderAndCheckOutWatch.mdCartModal.cart!.first.subTotal!.toDouble())}',
                isTotal: false),
          ],
        ),
      );
    });
  }

  coupanFieldWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promo Code',
            style:
                utils.headingStyleB(theme.orangeColor, fontFamily: 'finalBold'),
          ),
          // Consumer<OrderCheckOutWishlistController>(
          //     builder: (context, orderAndCheckOutWatch, _) {
          //   return
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 2.w) +
                    EdgeInsets.only(right: 15.w),
                margin: EdgeInsets.symmetric(vertical: 7.h),
                decoration: BoxDecoration(
                    color: theme.whiteColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: Colors.transparent,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: TextFormField(
                          controller:
                              orderAndCheckOutWatch.couponCodeController,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          style: utils.headingStyle(theme.blackColor),
                          cursorColor: theme.orangeColor,
                          decoration: InputDecoration.collapsed(
                            hintText: "Enter promo code",
                            hintStyle: utils.headingStyle(
                              theme.blackColor.withOpacity(.2),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (orderAndCheckOutWatch
                            .couponCodeController.text.isEmpty) {
                          utils.showToast(context,
                              message: 'Please enter promo code');
                        } else {
                          if (orderAndCheckOutWatch.canCouponApply == false) {
                            orderAndCheckOutRead.validateCoupanApi(context);
                          } else {
                            // SharedPreferences myPrefs =
                            //     await SharedPreferences.getInstance();
                            // myPrefs.remove(static.discountCouponString);
                            orderAndCheckOutRead.validateCoupanApi(context,
                                isFromRemove: true);
                            orderAndCheckOutRead.couponCodeController.clear();
                            orderAndCheckOutRead.updateSubtotal(
                                isFromRemove: true);
                            orderAndCheckOutRead.canCouponApplyUpdate(
                                value: false);
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          orderAndCheckOutWatch.canCouponApply
                              ? 'Remove'
                              : 'Apply',
                          style: utils.headingStyleB(
                              orderAndCheckOutWatch.canCouponApply
                                  ? theme.redColor
                                  : theme.orangeColor,
                              fontFamily: 'finalBold'),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          // }),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget placeOrderButton() {
    return Hero(
      tag: 'checkout',
      child: Container(
        width: static.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        child: utils.button(
          textSize: static.width > 550 ? 10.sp : 20.sp,
          text: 'Place Order',
          buttonColor: theme.orangeColor,
          borderColor: theme.orangeColor,
          fontFamily: 'finalBold',
          ontap: () async {
            // SuccessfulOrderBottomSheet().sheet(navigatorkey.currentContext!);

            // print((orderAndCheckOutWatch
            //     .mdCartModal.cart!.first.subTotal.runtimeType
            //     .toString()));
            // print((orderAndCheckOutWatch.mdCartModal.cart!.first.subTotal
            //     .toString()));

            String paymentAmount = orderAndCheckOutWatch.isFromOrderDetail
                ? ((orderAndCheckOutWatch
                        .mdOrderDetailModal.order!.first.orderPrice!)
                    .toString())
                : ((orderAndCheckOutWatch.mdCartModal.cart!.first.subTotal!))
                    .toString();

            if (orderAndCheckOutWatch.stripe &&
                !orderAndCheckOutWatch.buttonLoading) {
              await orderAndCheckOutRead.buttonLoadingUpdate(value: true);
              try {
                await StripeMethods().makePayment(payment: paymentAmount);
              } finally {
                await orderAndCheckOutRead.buttonLoadingUpdate(value: false);
              }
            }

            // else if (orderAndCheckOutWatch.googleAndApplePay && !orderAndCheckOutWatch.buttonLoading) {
            //   await orderAndCheckOutRead.buttonLoadingUpdate(value: true);
            //
            //   Platform.isAndroid
            //       ? GoogleAndApplePay().initGooglePayPayment(
            //           serviceName: 'Single Service',
            //           serviceType: 'Diamond',
            //           needToPayAmount: 10.0,
            //         )
            //       : GoogleAndApplePay().initApplePayPayment(
            //           serviceName: 'Single Service',
            //           serviceType: 'Diamond',
            //           needToPayAmount: 10.0,
            //         );
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) =>  HomeScreen()),
            //     // );
            //
            //     await orderAndCheckOutRead.buttonLoadingUpdate(value: false);
            //
            // }

            else if (orderAndCheckOutWatch.payPal) {
              await Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => WebViewPayPal(((paymentAmount)))))
                  .then((value) async {
                if (value != null) {
                  MDPayPal paypal = value;
                  print("The paypal Token is:" + paypal.token.toString());
                  print("the paypal payer id is:" + paypal.payerID.toString());
                  print("The paypal id is: " + paypal.paymentId.toString());

                  if (orderAndCheckOutWatch.isFromOrderDetail) {
                    orderAndCheckOutWatch.reOrderApi(
                        navigatorkey.currentContext,
                        orderID: orderAndCheckOutWatch.orderID,
                        transactionID: paypal.paymentId);
                  } else {
                    orderAndCheckOutWatch.checkoutApi(
                        navigatorkey.currentContext,
                        transactionID: paypal.paymentId);
                  }
                }
              });
            }
          },
          textColor: theme.whiteColor,
          width: static.width,
        ),
      ),
    );
  }

  //................. Functions ...................//

  paymentMethodSelectionContainer({image, onTap, status}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Images/$image.png',
              height: 35.h,
              width: 50.w,
            ),
            Spacer(),
            Container(
              width: 16.w,
              height: 16.w,
              //padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2..w),
              decoration: BoxDecoration(
                color: theme.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(color: theme.orangeColor, width: 1.5.r),
              ),
              child: status
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2..w),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: theme.orangeColor),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  pricesContainer({heading, price, isTotal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: static.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$heading',
            style:
                utils.labelStyle(theme.midGreyColor, fontFamily: 'finalBook'),
          ),
          Text(
            '\$$price',
            style: isTotal
                ? utils.generalHeading(theme.orangeColor,
                    fontFamily: 'finalBold', size: 25.sp)
                : utils.headingStyle(theme.orangeColor,
                    fontFamily: 'finalBold'),
          )
        ],
      ),
    );
  }
}

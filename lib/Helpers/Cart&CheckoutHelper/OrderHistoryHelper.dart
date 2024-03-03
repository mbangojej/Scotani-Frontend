import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/main.dart';

class OrderHistoyStatusHelper {
  BuildContext context;

  OrderHistoyStatusHelper(this.context);

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

  Widget backGroundImage() {
    return Container(
      child: Image.asset('assets/Images/orderHistoryBackground.png',
          width: static.width, fit: BoxFit.contain),
    );
  }

  Widget orderHistoryText() {
    return utils.appBar(
      context,
      barText: 'Order Tracking',
    );
  }

  Widget status() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          statusBox(
              color: orderAndCheckOutWatch.orderStatus == "0" ||
                      orderAndCheckOutWatch.orderStatus == "1" ||
                      orderAndCheckOutWatch.orderStatus == "2" ||
                      orderAndCheckOutWatch.orderStatus == "3" ||
                      orderAndCheckOutWatch.orderStatus == "5"
                  ? theme.greenColor
                  : theme.midGreyColor,
              heading: 'Order Received',
              subHeading: 'Your order is placed successfully'),
          dottedLine(
            color: orderAndCheckOutWatch.orderStatus == '1'
                ? orderAndCheckOutWatch.orderStatus == "1"
                    ? theme.greenColor
                    : theme.midGreyColor
                : orderAndCheckOutWatch.orderStatus == "1" ||
                        orderAndCheckOutWatch.orderStatus == "2" ||
                        orderAndCheckOutWatch.orderStatus == "3" ||
                        orderAndCheckOutWatch.orderStatus == "5"
                    ? theme.greenColor
                    : theme.midGreyColor,
          ),
          statusBox(
              color: orderAndCheckOutWatch.orderStatus == '1'
                  ? orderAndCheckOutWatch.orderStatus == "1"
                      ? theme.greenColor
                      : theme.midGreyColor
                  : orderAndCheckOutWatch.orderStatus == "1" ||
                          orderAndCheckOutWatch.orderStatus == "2" ||
                          orderAndCheckOutWatch.orderStatus == "3" ||
                          orderAndCheckOutWatch.orderStatus == "5"
                      ? theme.greenColor
                      : theme.midGreyColor,
              heading: 'Processing',
              subHeading: 'Your order is under process'),
          dottedLine(
            color: orderAndCheckOutWatch.orderStatus == "2" ||
                    orderAndCheckOutWatch.orderStatus == "3" ||
                    orderAndCheckOutWatch.orderStatus == "5"
                ? theme.greenColor
                : theme.midGreyColor,
          ),
          statusBox(
              color: orderAndCheckOutWatch.orderStatus == "2" ||
                      orderAndCheckOutWatch.orderStatus == "3" ||
                      orderAndCheckOutWatch.orderStatus == "5"
                  ? theme.greenColor
                  : theme.midGreyColor,
              heading: 'On the Way',
              subHeading: 'Our Agent will soon deliver your product'),
          dottedLine(
            color: orderAndCheckOutWatch.orderStatus == "3" ||
                    orderAndCheckOutWatch.orderStatus == "5"
                ? theme.greenColor
                : theme.midGreyColor,
          ),
          statusBox(
              color: orderAndCheckOutWatch.orderStatus == "3" ||
                      orderAndCheckOutWatch.orderStatus == "5"
                  ? theme.greenColor
                  : theme.midGreyColor,
              heading: 'Product Delivered',
              subHeading: 'Awesome. Have a great day.'),
          dottedLine(
            color: orderAndCheckOutWatch.orderStatus == "5"
                ? theme.greenColor
                : theme.midGreyColor,
          ),
          statusBox(
              color: orderAndCheckOutWatch.orderStatus == "5"
                  ? theme.greenColor
                  : theme.midGreyColor,
              heading: 'Refunded',
              subHeading: 'Refund payment completed successfully.'),
        ],
      ),
    );
  }

  Widget cancelMyOrder() {
    return orderAndCheckOutWatch.orderStatus == "1" ||
            orderAndCheckOutWatch.orderStatus == "2" ||
            orderAndCheckOutWatch.orderStatus == "3" ||
            orderAndCheckOutWatch.orderStatus == "5"
        ? Container()
        : Container(
            width: static.width,
            padding: EdgeInsets.symmetric(horizontal:static.width > 500 ? 40.w : 20.w, vertical: static.width > 500 ? 15.h : 18.h),
            child: utils.button(
              textSize: static.width > 500 ? 15.sp : 20.sp,
              text: orderAndCheckOutWatch.orderStatus == '4'
                  ? 'Order Canceled'
                  : 'Cancel My Order',
              buttonColor: theme.redColor,
              borderColor: theme.redColor,
              fontFamily: 'finalBold',
              ontap: () async {
                orderAndCheckOutWatch.orderStatus == '4'
                    ? true
                    : utils.exitingAppDialog(context,
                        headingTextColor: theme.blackColor,
                        dialogColor: theme.whiteColor,
                        icon: 'alertAnime',
                        heading: 'Alert',
                        message: "Are you sure you want to cancel this order?",
                        positiveButton: 'YES',
                        negativeButton: 'NO', positiveAction: () {
                        orderAndCheckOutRead.cancelOrderApi(context,
                            orderID: orderAndCheckOutWatch.orderID);
                      }, negativeAction: () {
                        Navigator.pop(context);
                      });

                // utils.genericDialog(
                //   context,
                //   dialogColor: theme.lightBlackColor,
                //   headingTextColor: theme.whiteColor,
                //   heading: 'Are you sure you want to cancel this order?',
                //   negativeActionText: 'NO',
                //   positiveActionText: 'YES',
                //   negativeAction: () {
                //     Navigator.pop(context);
                //   },
                //   positiveAction: () {
                //     orderAndCheckOutRead.cancelOrderApi(context,
                //         orderID: orderAndCheckOutWatch.orderID);
                //   },
                // );
              },
              textColor: theme.whiteColor,
              width: static.width,
            ),
          );
  }

  statusBox({color, heading, subHeading}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: static.width > 500 ? 25.w : 30.w,
          height: static.width > 500 ? 25.w : 30.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.checkmark_alt,
            size: 22.sp,
            color: theme.whiteColor,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: utils.xHeadingStyleB(theme.whiteColor),
            ),
            SizedBox(
              height: 0.h,
            ),
            Text(
              subHeading,
              style: utils.smallLabelStyle(theme.midGreyColor),
            ),
          ],
        )
      ],
    );
  }

  dottedLine({color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: static.width > 500 ? 12.w : 15.w),
      child: SizedBox(
        height: 60.h,
        child: CustomPaint(
          painter: DottedLinePainter(
            color: color,
            dashLength: 2.h,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double strokeWidth;
  final double dashLength;
  final Color color;

  DottedLinePainter(
      {this.strokeWidth = 1.0,
      this.dashLength = 5.0,
      this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final startY = 0.0;
    final endY = size.height;

    double currentY = startY;

    while (currentY <= endY) {
      canvas.drawLine(
          Offset(0.0, currentY), Offset(0.0, currentY + dashLength), paint);
      currentY +=
          dashLength * 2; // Skip the same length as the dash for spacing
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

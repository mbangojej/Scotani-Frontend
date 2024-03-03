import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDOrderModal.dart';
import 'package:skincanvas/main.dart';

class OrdersWidget extends StatefulWidget {
  Orders? orders;
  Function()? onTap;

  OrdersWidget({this.orders, this.onTap});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  Color? orderColor;
  String status = '';
  String names = '';

  var orderRead = Provider.of<OrderCheckOutWishlistController>(navigatorkey.currentContext!, listen: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("order status ${widget.orders!.orderStatus}");

    if (widget.orders!.orderStatus == '0') {
      orderColor = theme.orangeColor;
      status = "Order Received";
    } else if (widget.orders!.orderStatus == '1') {
      orderColor = theme.orangeColor;
      status = "Processing";
    } else if (widget.orders!.orderStatus == '2') {
      orderColor = theme.orangeColor;
      status = "On The Way";
    } else if (widget.orders!.orderStatus == '3') {
      orderColor = theme.greenColor;
      status = "Delivered";
    } else if (widget.orders!.orderStatus == '4') {
      orderColor = theme.redColor;
      status = "Cancel";
    } else if (widget.orders!.orderStatus == '5') {
      orderColor = theme.redColor;
      status = "Refunded";
    }

    if (widget.orders!.orderStatus == 'Order Received') {
      orderColor = theme.orangeColor;
      status = "0";
    } else if (widget.orders!.orderStatus == 'Processing') {
      orderColor = theme.orangeColor;
      status = "1";
    } else if (widget.orders!.orderStatus == 'On The Way') {
      orderColor = theme.orangeColor;
      status = "2";
    } else if (widget.orders!.orderStatus == 'Delivered') {
      orderColor = theme.greenColor;
      status = "3";
    } else if (widget.orders!.orderStatus == 'Cancel') {
      orderColor = theme.redColor;
      status = "4";
    }else if (widget.orders!.orderStatus == 'Refunded') {
      orderColor = theme.redColor;
      status = "5";
    }

    names = widget.orders!.products!
        .map((product) => product.productName)
        .join(', ');
    setState(() {});

    return widget.orders!.orderStatus == '0' ||
            widget.orders!.orderStatus == '1' ||
            widget.orders!.orderStatus == '2'
        ? GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70.w,
                        height: 60.h,
                        child: Stack(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.h,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.lightGreyColor,
                                border: Border.all(
                                    color: theme.whiteColor, width: 2.w),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${widget.orders!.products![0].productImage}',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        utils.loadingShimmer(
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                errorWidget: (context, url, error) =>
                                    utils.loadingShimmer(
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                            if (widget.orders!.products!.length > 1)
                              Positioned(
                                top: 4.h,
                                left: 4.w,
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.lightGreyColor,
                                    border: Border.all(
                                        color: theme.whiteColor, width: 2.w),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${widget.orders!.products![1].productImage}',
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            utils.loadingShimmer(
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        utils.loadingShimmer(
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            if (widget.orders!.products!.length > 2)
                              Positioned(
                                top: 10.h,
                                left: 8.h,
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.lightGreyColor,
                                    border: Border.all(
                                        color: theme.whiteColor, width: 2.w),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${widget.orders!.products![2].productImage}',
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            utils.loadingShimmer(
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        utils.loadingShimmer(
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID: " + widget.orders!.orderID!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: utils.xHeadingStyle(
                              theme.whiteColor,
                              fontFamily: 'finalBold',
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            utils.convertUTCToCurrentDate(
                                dateString: widget.orders!.orderDate!),
                            style: utils.labelStyle(theme.whiteColor,
                                fontFamily: 'finalBold'),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          // SizedBox(
                          //   height: 4.h,
                          // ),
                          // Text(
                          //   names,
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: utils.labelStyle(
                          //     theme.midGreyColor,
                          //   ),
                          // ),
                        ],
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            orderRead.orderStatusUpdate(
                                status: widget.orders!.orderStatus.toString(),
                                ID: widget.orders!.sId.toString(),
                                backToNavigate: true);
                            Navigator.pushNamed(context,
                                Routes().orderHistoryStatusScreenRoute);
                          },
                          child: Text(
                            "Track",
                            style: utils.labelStyle(theme.orangeColor,
                                fontFamily: 'finalBold'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Divider(
                    color: theme.midGreyColor.withOpacity(.6),
                    thickness: 0.3,
                  ),
                ],
              ),
            ),
          )
        : SwipeActionCell(
            backgroundColor: Colors.transparent,
            key: ObjectKey(widget.orders!.orderID),
            deleteAnimationDuration: 0,
            fullSwipeFactor: 0.5,
            index: 1,
            trailingActions: <SwipeAction>[
              SwipeAction(
                performsFirstActionWithFullSwipe: true,
                widthSpace: 160.w,
                title: 'Remove From List',
                style:
                    utils.labelStyle(theme.whiteColor, fontFamily: 'finalBold'),
                onTap: (CompletionHandler handler) async {
                  orderRead.deleteOrderApi(context,
                      orderID: widget.orders!.sId);

                  handler(false);
                },
                color: theme.redColor,
              ),
            ],
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.w,
                          height: 60.h,
                          child: Stack(
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.lightGreyColor,
                                  border: Border.all(
                                      color: theme.whiteColor, width: 2.w),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${widget.orders!.products![0].productImage}',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          utils.loadingShimmer(
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      utils.loadingShimmer(
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              if (widget.orders!.products!.length > 1)
                                Positioned(
                                  top: 4.h,
                                  left: 4.w,
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: theme.lightGreyColor,
                                      border: Border.all(
                                          color: theme.whiteColor, width: 2.w),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${widget.orders!.products![1].productImage}',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              utils.loadingShimmer(
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          utils.loadingShimmer(
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              if (widget.orders!.products!.length > 2)
                                Positioned(
                                  top: 10.h,
                                  left: 8.h,
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: theme.lightGreyColor,
                                      border: Border.all(
                                          color: theme.whiteColor, width: 2.w),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${widget.orders!.products![2].productImage}',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              utils.loadingShimmer(
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          utils.loadingShimmer(
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID : " + widget.orders!.orderID!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: utils.xHeadingStyle(
                                theme.whiteColor,
                                fontFamily: 'finalBold',
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              utils.convertUTCToCurrentDate(
                                  dateString: widget.orders!.orderDate),
                              style: utils.labelStyle(theme.whiteColor,
                                  fontFamily: 'finalBold'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            // SizedBox(
                            //   height: 4.h,
                            // ),
                            // Text(
                            //   "Order ID : " + widget.OrderTitle,
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: utils.labelStyle(
                            //     theme.midGreyColor,
                            //   ),
                            // ),
                          ],
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              orderRead.orderStatusUpdate(
                                  status: widget.orders!.orderStatus.toString(),
                                  ID: widget.orders!.sId.toString(),
                                  backToNavigate: true);
                              Navigator.pushNamed(context,
                                  Routes().orderHistoryStatusScreenRoute);
                            },
                            child: Text(
                              "Track",
                              style: utils.labelStyle(theme.orangeColor,
                                  fontFamily: 'finalBold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Divider(
                      color: theme.midGreyColor.withOpacity(.6),
                      thickness: 0.3,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

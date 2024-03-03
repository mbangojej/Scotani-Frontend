import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/MyWishListContainer.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Views/Cart&Checkout/CheckoutScreen.dart';
import 'package:skincanvas/main.dart';

class OrderDetailHelper {
  BuildContext context;

  OrderDetailHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  Color? orderColor;

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  Widget MyWishListText() {
    return utils.appBar(context, barText: 'Order Detail', onPress: () {
      orderRead.indexForOrderDetailImageUpdate(index: 0);
      Navigator.pop(context);
    });
  }

  Widget myCartList() {
    print(
        "dsfsf ${orderWatch.mdOrderDetailModal.order!.first.products!.length}");
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          height: static.height * .35,
          width: static.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: theme.backGroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: CarouselSlider(
            items: [
              // if (orderWatch.mdOrderDetailModal.order!.first.products!.first.designs!.isNotEmpty &&orderWatch.mdOrderDetailModal.order!.first.products!.first.productImage == "") ...[
              //   for (int i = 0; i < orderWatch.mdOrderDetailModal.order!.first.products!.first.designs!.length; i++)
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         width: static.width,
              //         decoration: BoxDecoration(
              //           color: theme.backGroundColor,
              //         ),
              //         child: CachedNetworkImage(
              //           imageUrl:
              //               '${orderWatch.mdOrderDetailModal.order!.first.products!.first.designs![i].image}',
              //           progressIndicatorBuilder:
              //               (context, url, downloadProgress) =>
              //                   utils.loadingShimmer(
              //             height: static.width * .5.w,
              //             width: static.width * .5.w,
              //           ),
              //           errorWidget: (context, url, error) =>
              //               utils.loadingShimmer(
              //             height: static.width * .5.w,
              //             width: static.width * .5.w,
              //           ),
              //           fit: BoxFit.contain,
              //         ),
              //       ),
              //     ),
              // ] else ...[
              for (int i = 0; i < orderWatch.combineImagesList.length; i++)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: static.width,
                    decoration: BoxDecoration(
                      color: theme.backGroundColor,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${orderWatch.combineImagesList[i]}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              utils.loadingShimmer(
                        height: static.width * .5.w,
                        width: static.width * .5.w,
                      ),
                      errorWidget: (context, url, error) =>
                          utils.loadingShimmer(
                        height: static.width * .5.w,
                        width: static.width * .5.w,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              // ]
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                orderRead.indexForOrderDetailImageUpdate(index: index);
              },
              height: MediaQuery.of(context).size.height,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlay: false,
              //aspectRatio: 16 / 16,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
          ), ///////Working
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // if (orderWatch.mdOrderDetailModal.order!.first.products!.first
              //         .designs!.isNotEmpty &&
              //     orderWatch.mdOrderDetailModal.order!.first.products!.first
              //             .productImage ==
              //         "") ...[
              //   for (int i = 0;
              //       i <
              //           orderWatch.mdOrderDetailModal.order!.first.products!
              //               .first.designs!.length;
              //       i++)
              //     orderWatch.indexForOrderDetailImages == i ||
              //             orderWatch.mdOrderDetailModal.order!.first.products!
              //                     .first.designs!.length ==
              //                 1
              //         ? Container(
              //             margin: EdgeInsets.symmetric(horizontal: 3.w),
              //             width: 14.w,
              //             height: 14.w,
              //             decoration: BoxDecoration(
              //                 color: theme.transparentColor,
              //                 shape: BoxShape.circle,
              //                 border: Border.all(
              //                     color: theme.whiteColor, width: .5)),
              //             child: Container(
              //               margin: EdgeInsets.symmetric(horizontal: 1.w),
              //               decoration: BoxDecoration(
              //                   color: theme.orangeColor,
              //                   shape: BoxShape.circle,
              //                   border: Border.all(color: theme.orangeColor)),
              //             ),
              //           )
              //         : Container(
              //             alignment: Alignment.center,
              //             margin: EdgeInsets.symmetric(horizontal: 3.w),
              //             width: 12.w,
              //             height: 12.w,
              //             decoration: BoxDecoration(
              //               color: theme.lightBlackColor,
              //               shape: BoxShape.circle,
              //             ),
              //           )
              // ] else ...[
              for (int i = 0; i < orderWatch.combineImagesList.length; i++)
                orderWatch.indexForOrderDetailImages == i
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: 14.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                            color: theme.transparentColor,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: theme.whiteColor, width: .5)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          decoration: BoxDecoration(
                              color: theme.orangeColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.orangeColor)),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: theme.lightBlackColor,
                          shape: BoxShape.circle,
                        ),
                      )
              // ]
            ],
          ),
        )
      ],
    );
  }

  Widget description() {
    var names =
        orderWatch.mdOrderDetailModal.order!.first.products!.map((product) {
      if (product.designs != null && product.designs!.isNotEmpty) {
        return product.designs!.first.prompt;
      } else {
        return product.productName;
      }
    }).join(', ');

    print(
        "Order Srasda ${orderWatch.mdOrderDetailModal.order!.first.orderStatus}");

    if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '0' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus ==
            'Order Received') {
      orderColor = theme.orangeColor;
    } else if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '1' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus ==
            'Processing') {
      orderColor = theme.orangeColor;
    } else if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '2' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus ==
            'On The Way') {
      orderColor = theme.orangeColor;
    } else if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '3' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus == 'Delivered') {
      orderColor = theme.greenColor;
    } else if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '4' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus == 'Cancel') {
      orderColor = theme.redColor;
    } else if (orderWatch.mdOrderDetailModal.order!.first.orderStatus == '5' ||
        orderWatch.mdOrderDetailModal.order!.first.orderStatus == 'Refunded') {
      orderColor = theme.redColor;
    }
    print("order Color ${orderColor.toString()}");

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(top: 30.h),
      width: static.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Order',
              style: utils.xxlHeadingStyleB(theme.whiteColor,
                  fontFamily: 'finalBold'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              '${names}',
              style: utils.xlHeadingStyleB(theme.whiteColor,
                  fontFamily: 'finalBold'),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Date',
                  style: utils.xHeadingStyle(theme.midGreyColor,
                      fontFamily: 'finalBold'),
                ),
                Text(
                  '${utils.convertUTCToCurrentDate(dateString: orderWatch.mdOrderDetailModal.order!.first.orderDate)}',
                  style: utils.headingStyle(theme.midGreyColor,
                      fontFamily: 'finalBook'),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: utils.xHeadingStyle(theme.midGreyColor,
                      fontFamily: 'finalBold'),
                ),
                Text(
                  '${orderWatch.mdOrderDetailModal.order!.first.orderID}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: utils.headingStyle(theme.midGreyColor,
                      fontFamily: 'finalBook'),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: utils.xHeadingStyle(theme.midGreyColor,
                      fontFamily: 'finalBold'),
                ),
                Text(
                  '${orderWatch.mdOrderDetailModal.order!.first.orderStatus}',
                  style:
                      utils.headingStyle(orderColor, fontFamily: 'finalBook'),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            // orderWatch.mdOrderDetailModal.order!.first.deliveredDate!.isEmpty ||
            //         orderWatch.mdOrderDetailModal.order!.first.deliveredDate == null
            //     ? SizedBox()
            //     : Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             orderWatch.mdOrderDetailModal.order!.first.orderStatus ==
            //                         '5' ||
            //                     orderWatch.mdOrderDetailModal.order!.first
            //                             .orderStatus ==
            //                         'Refunded'
            //                 ? 'Refunded Date'
            //                 : 'Delivery date',
            //             style: utils.labelStyle(theme.midGreyColor,
            //                 fontFamily: 'finalBook'),
            //           ),
            //           Text(
            //             '${utils.convertUTCToCurrentDate(dateString: orderWatch.mdOrderDetailModal.order!.first.orderStatus == '5' || orderWatch.mdOrderDetailModal.order!.first.orderStatus == 'Refunded' ? orderWatch.mdOrderDetailModal.order!.first.refundedDate : orderWatch.mdOrderDetailModal.order!.first.deliveredDate)}',
            //             style: utils.smallLabelStyle(theme.whiteColor,
            //                 fontFamily: 'finalBook'),
            //           ),
            //         ],
            //       ),
            ((!orderWatch.mdOrderDetailModal.order!.first.deliveredDate!
                                .isEmpty &&
                            orderWatch.mdOrderDetailModal.order!.first
                                    .deliveredDate !=
                                null) &&
                        !(orderWatch.mdOrderDetailModal.order!.first
                                    .orderStatus ==
                                '5' ||
                            orderWatch.mdOrderDetailModal.order!.first
                                    .orderStatus ==
                                'Refunded')) ||
                    ((orderWatch.mdOrderDetailModal.order!.first.deliveredDate!
                                .isEmpty ||
                            orderWatch.mdOrderDetailModal.order!.first
                                    .deliveredDate ==
                                null) &&
                        (orderWatch.mdOrderDetailModal.order!.first
                                    .orderStatus ==
                                '5' ||
                            orderWatch.mdOrderDetailModal.order!.first
                                    .orderStatus ==
                                'Refunded'))
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderWatch.mdOrderDetailModal.order!.first
                                        .orderStatus ==
                                    '5' ||
                                orderWatch.mdOrderDetailModal.order!.first
                                        .orderStatus ==
                                    'Refunded'
                            ? 'Refunded Date'
                            : 'Delivery date',
                        style: utils.xHeadingStyle(theme.midGreyColor,
                            fontFamily: 'finalBold'),
                      ),
                      Text(
                        '${utils.convertUTCToCurrentDate(dateString: orderWatch.mdOrderDetailModal.order!.first.orderStatus == '5' || orderWatch.mdOrderDetailModal.order!.first.orderStatus == 'Refunded' ? orderWatch.mdOrderDetailModal.order!.first.refundedDate : orderWatch.mdOrderDetailModal.order!.first.deliveredDate)}',
                        style: utils.headingStyle(theme.whiteColor,
                            fontFamily: 'finalBook'),
                      ),
                    ],
                  )
                : SizedBox(),

            // SizedBox(
            //   height: 15.h,
            // ),
            // orderWatch.mdOrderDetailModal.order!.first.aboutOrder!.isNotEmpty ||
            //         orderWatch.mdOrderDetailModal.order!.first.aboutOrder != ''
            //     ? Text(
            //         'About Order',
            //         style: utils.xlHeadingStyle(theme.whiteColor,
            //             fontFamily: 'finalBold'),
            //       )
            //     : SizedBox(),
            // SizedBox(
            //   height: 8.h,
            // ),
            // Text(
            //   '${orderWatch.mdOrderDetailModal.order!.first.aboutOrder}',
            //   style: utils.generalHeading(theme.whiteColor.withOpacity(.8),
            //       fontFamily: 'finalBook', size: 13.sp),
            // ),
          ],
        ),
      ),
    );
  }

  Widget priceOfOrder() {
    print(
        "Order Status ${orderWatch.mdOrderDetailModal.order!.first.orderStatus}");
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      height: 70.h,
      color: theme.lightBlackColor,
      child: Row(
        children: [
          Text(
            'Total',
            style: utils.xlHeadingStyleB(theme.whiteColor,
                fontFamily: 'finalBold'),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            '\$${orderWatch.mdOrderDetailModal.order!.first.orderPrice!.toStringAsFixed(2)}',
            style: utils.xlHeadingStyle(theme.orangeColor,
                fontFamily: 'finalBold'),
          ),
          Expanded(child: SizedBox()),
          if (orderWatch.mdOrderDetailModal.order!.first.orderStatus
                  .toString() ==
              'Delivered')
            Container(
              width: static.width > 550 ? static.width * .4 : static.width * .5,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: utils.button(
                textSize: static.width > 550 ? 10.sp : 20.sp,
                text: 'Reorder',
                buttonColor: theme.orangeColor,
                borderColor: theme.orangeColor,
                fontFamily: 'finalBold',
                ontap: () async {
                  await orderRead.routeFromOrderDetailUpdate(value: true);
                  await orderRead.orderStatusUpdate(
                      status: '0',
                      ID: orderWatch.mdOrderDetailModal.order!.first.sId
                          .toString(),
                      backToNavigate: false);
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => CheckOutScreen(),
                  //     ));
                  Navigator.pushNamed(context, route.checkOutScreenRoute);

                  //  await authRead.signInApi(context);
                },
                textColor: theme.whiteColor,
                width: static.width,
              ),
            ),
        ],
      ),
    );
  }
}

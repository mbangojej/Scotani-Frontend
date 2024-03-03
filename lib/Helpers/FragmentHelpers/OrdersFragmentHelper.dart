import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/OrdersWidget.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Views/PlaceOrder/OrderDetailScreen.dart';
import 'package:skincanvas/main.dart';

class OrdersFragmentHelper {
  BuildContext context;
  ScrollController scrollController;

  OrdersFragmentHelper(this.context, this.scrollController) {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        if (orderWatch.mdOrderModal.data!.pagination!.pages!.toInt() >= orderWatch.orderPage) {
          await orderRead.orderListingApi(context,
              searching: '', isLoading: true, page: orderWatch.orderPage);
        }
        print('scroll');
      }
    });
  }

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();
  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  Widget orderHistoryText() {
    return Consumer<GeneralController>(builder: (context, generalWatch, _) {
      return Container(
        padding:
            EdgeInsets.symmetric(horizontal: 10.w) + EdgeInsets.only(top: 20.h),
        width: static.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: static.width * .6,
              child: Text(
                'Order History',
                style: utils.generalHeadingBold(theme.whiteColor,
                    size: static.width > 550 ? 20.sp : 26.sp,
                    fontFamily: 'finalBold'),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();

                utils.flipCard(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                    color: theme.lightBlackColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.greyColor.withOpacity(.8))),
                child: Container(
                  width: static.width > 500 ? 40.w : 45.w,
                  height: static.width > 500 ? 40.h : 45.h,
                  margin: static.width > 500
                      ? EdgeInsets.all(2.w)
                      : EdgeInsets.all(0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.lightGreyColor,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: generalWatch.profilePhotoValue!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            utils.loadingShimmer(
                      width: 30.w,
                      height: 30.h,
                    ),
                    errorWidget: (context, url, error) => utils.loadingShimmer(
                      width: 30.w,
                      height: 30.h,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget fieldForSearch() {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'Search "SC00012"',
        isSecure: false,
        controller: orderWatch.searchOrderController,
        maxLines: 1,
        postfixIcon: 'search',
        postfixClick: () async{
          await orderRead.orderListingApi(context,
              isLoading: true, searching: orderWatch.searchOrderController.text, page: 1);
        },
        postfixIconColor: theme.greyColor,
        postFixIconSize: static.width > 550 ? 12.w : 20.w,
        onChange: (text) async {
          //   print("The text is"+ text.toString());

          // if (text == '') {
          //   await orderRead.orderSearchPageUpdate(value: 1);
          // }
          if(text == '')
          await orderRead.orderListingApi(context,
              isLoading: true, searching: text, page: 1);
        },
      ),
    );
  }

  Widget OrderHistory() {
    return Consumer<OrderCheckOutWishlistController>(
        builder: (context, orderWatch, _) {
      return orderWatch.isLoadingOrderList
          ? Container(
              alignment: Alignment.center,
              child: utils.noDataFound(text: 'No Orders Found'))
          : SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      for (int i = 0; i < orderWatch.ordersList.length; i++)
                        if (orderWatch.ordersList[i].products!.isNotEmpty)
                          OrdersWidget(
                            orders: orderWatch.ordersList[i],
                            onTap: () {
                              // if (orderWatch.ordersList[i].orderStatus
                              //         .toString() ==
                              //     '3') {
                              orderRead.orderDetailApi(context,
                                  orderID: orderWatch.ordersList[i].sId);
                              // }
                              // else if (orderWatch.ordersList[i].orderStatus
                              //             .toString() ==
                              //         '1' ||
                              //     orderWatch.ordersList[i].orderStatus
                              //             .toString() ==
                              //         '2' ||
                              //     orderWatch.ordersList[i].orderStatus
                              //             .toString() ==
                              //         '0') {
                              //   orderRead.orderStatusUpdate(
                              //       status: orderWatch.ordersList[i].orderStatus
                              //           .toString(),
                              //       ID: orderWatch.ordersList[i].sId.toString(),
                              //       backToNavigate: true);
                              //   Navigator.pushNamed(context,
                              //       route.orderHistoryStatusScreenRoute);
                              // }
                            },
                          ),
                    ],
                  )),
            );
    });
  }
}

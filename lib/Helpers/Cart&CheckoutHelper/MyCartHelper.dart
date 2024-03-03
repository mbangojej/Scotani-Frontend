import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/MyCartWidget.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/main.dart';

class MyCartHelper {
  BuildContext context;

  MyCartHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  Widget selectCategoryText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: static.width,
      color: theme.lightBlackColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Cart',
                style: utils.generalHeadingBold(theme.whiteColor,
                    size: static.width > 550 ? 18.sp : 24.sp,
                    fontFamily: 'finalBold'),
              ),
              Text(
                ' (${orderWatch.quantityOfCartProduct})',
                style: utils.generalHeadingBold(theme.orangeColor,
                    size: static.width > 550 ? 18.sp : 24.sp,
                    fontFamily: 'finalBold'),
              ),
            ],
          ),
          orderWatch.onCartFromHome
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.back,
                      color: theme.whiteColor,
                    ),
                    // Icon to display
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // Callback function when pressed
                    tooltip: 'Like', // Optional tooltip text
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, route.bottomNavigationScreenRoute);
                  },
                  child: Container(
                      padding: EdgeInsets.only(right: 5.w),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.home,
                        size: 28.w,
                        color: theme.whiteColor,
                      ))),
        ],
      ),
    );
  }

  Widget myCartList() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (orderWatch.systemProductListStatus.contains(true) ||
              orderWatch.nonSystemProductListStatus.contains(true)) ...[
            GestureDetector(
              onTap: () {
                orderRead.removeFromCartApi(
                  context,
                  systemProduct: orderWatch.systemProductListDeleteIDs,
                  nonSystemProductTattoos:
                      orderWatch.nonSystemProductTattoosListDeleteIDs,
                  nonSystemProductProducts:
                      orderWatch.nonSystemProductProductsListDeleteIDs,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 40.w),
                child: Text(
                  'Delete',
                  textAlign: TextAlign.end,
                  style: utils.xHeadingStyle(
                    theme.redColor,
                    fontFamily: 'finalBold',
                  ),
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.only(right: 40.w),
            child: Text(
              '',
              textAlign: TextAlign.end,
              style: utils.xHeadingStyle(
                theme.redColor,
                fontFamily: 'finalBold',
              ),
            ),
          ),
          orderWatch.listOfSystemProducts.length == 0 &&
                  orderWatch.listOfNonSystemProductsProduct.length == 0
              ? Container(
                  height: static.height * .5,
                  child: utils.noDataFound(text: "Cart is Empty!"),
                )
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    for (int i = 0;
                        i < orderWatch.listOfSystemProducts.length;
                        i++)
                      MyCartWidget(
                        productName:
                            '${orderWatch.listOfSystemProducts[i].productName}',
                        productAttribute: utils.convertHtmlToPlainText(
                            orderWatch
                                .listOfSystemProducts[i].productDescription
                                .toString()),
                        productPrice:
                            '${priceKey}${orderWatch.listOfSystemProducts[i].subTotal!.toStringAsFixed(2)}',
                        productImage:
                            '${orderWatch.listOfSystemProducts[i].productImage}',
                        productGraphicAndTextList: [],
                        onTap: () {
                          orderRead.systemProductCartDeleteListUpdate(
                              type: orderWatch
                                  .listOfSystemProducts[i].productType
                                  .toString(),
                              index: i,
                              id: orderWatch.listOfSystemProducts[i]
                                          .productType ==
                                      0
                                  ? orderWatch.listOfSystemProducts[i].sId
                                  : orderWatch
                                      .listOfSystemProducts[i].designID);
                        },
                        quantity: int.parse(orderWatch
                            .listOfSystemProducts[i].quantity
                            .toString()),
                        decrementOnTap: () {
                          orderRead.updateCartQuantitApi(
                            context,
                            quantity: orderWatch
                                    .listOfSystemProducts[i].quantity!
                                    .toInt() -
                                1,
                            type:
                                orderWatch.listOfSystemProducts[i].productType,
                            id: orderWatch.listOfSystemProducts[i].sId,
                            designId:
                                orderWatch.listOfSystemProducts[i].designID,
                          );
                        },
                        incrementOnTap: () {
                          orderRead.updateCartQuantitApi(
                            context,
                            quantity: orderWatch
                                    .listOfSystemProducts[i].quantity!
                                    .toInt() +
                                1,
                            type:
                                orderWatch.listOfSystemProducts[i].productType,
                            id: orderWatch.listOfSystemProducts[i].sId,
                            designId:
                                orderWatch.listOfSystemProducts[i].designID,
                          );
                        },
                        status: orderWatch.systemProductListStatus[i],
                        isFromProductScreen: homeWatch.isFromTattoo,
                      ),
                    //
                    // for (int i = 0; i < orderWatch.listOfNonSystemProductsProduct.length; i++)
                    //   if(orderWatch.listOfNonSystemProductsProduct[i].productId == null || orderWatch.listOfNonSystemProductsProduct[i].productId == "" )...[
                    //     MyCartWidget(
                    //       productName: '${orderWatch.listOfNonSystemProductsProduct[i].productName}',
                    //       productAttribute: '',
                    //       productPrice: '${priceKey}${orderWatch.listOfNonSystemProductsProduct[i].subTotal}',
                    //       // productQuantity: '${orderWatch.listOfSystemProducts[i].quantity}',
                    //       productImage: '${orderWatch.listOfNonSystemProductsProduct[i].productImage}',
                    //       productGraphicAndTextList: orderWatch.listOfNonSystemProductsProduct[i].designs!.toList(),
                    //       onTap: () {
                    //         orderRead.nonSystemProductCartDeleteListUpdate(index: i);
                    //       },
                    //       quantity: 1,
                    //       decrementOnTap: () {
                    //         orderRead.quantityListSelectionUpdate(index: 0, isDecrement: true, isIncrement: false);
                    //       },
                    //       incrementOnTap: () {
                    //         orderRead.quantityListSelectionUpdate(index: 0, isDecrement: false, isIncrement: true);
                    //       },
                    //       status: orderWatch.nonSystemProductListStatus[i],
                    //       isFromProductScreen: !homeWatch.isFromTattoo,
                    //     ),
                    //   ]
                    // else...[
                    //     MyCartWidget(
                    //       productName: '${orderWatch.listOfNonSystemWholeProduct[i].productName}',
                    //       productAttribute: '',
                    //       productPrice: '${priceKey}${orderWatch.listOfNonSystemWholeProduct[i].subTotal}',
                    //       // productQuantity: '${orderWatch.listOfSystemProducts[i].quantity}',
                    //       productImage: '${orderWatch.listOfNonSystemWholeProduct[i].productImage}',
                    //       productGraphicAndTextList: orderWatch.listOfNonSystemWholeProduct[i].designs!.toList(),
                    //       onTap: () {
                    //         orderRead.nonSystemProductCartDeleteListUpdate(index: i);
                    //       },
                    //       quantity: 1,
                    //       decrementOnTap: () {orderRead.quantityListSelectionUpdate(index: 0, isDecrement: true, isIncrement: false);
                    //       },
                    //       incrementOnTap: () {
                    //         orderRead.quantityListSelectionUpdate(index: 0, isDecrement: false, isIncrement: true);
                    //       },
                    //       status: orderWatch.nonSystemProductListStatus[i],
                    //       isFromProductScreen: !homeWatch.isFromTattoo,
                    //     ),

                    for (int i = 0;
                        i < orderWatch.listOfNonSystemProductsProduct.length;
                        i++) ...[
                      MyCartWidget(
                        productName:
                            '${orderWatch.listOfNonSystemProductsProduct[i].productName}',
                        productAttribute: '',
                        productPrice:
                            '${priceKey}${orderWatch.listOfNonSystemProductsProduct[i].subTotal!.toStringAsFixed(2)}',
                        // productQuantity: '${orderWatch.listOfSystemProducts[i].quantity}',
                        productImage:
                            '${orderWatch.listOfNonSystemProductsProduct[i].productImage}',
                        productGraphicAndTextList: orderWatch
                            .listOfNonSystemProductsProduct[i].designs!
                            .toList(),
                        onTap: () {
                          //orderRead.nonSystemProductCartDeleteListUpdate(index: i);

                          orderRead.nonSystemProductCartDeleteListUpdate(
                              index: i,
                              id: orderWatch
                                  .listOfNonSystemProductsProduct[i].sId);
                        },
                        quantity: orderWatch
                            .listOfNonSystemProductsProduct[i].quantity!
                            .toInt(),
                        decrementOnTap: () {
                          if (orderWatch
                                  .listOfNonSystemProductsProduct[i].quantity!
                                  .toInt() >
                              1)
                            orderRead.updateCartQuantitApi(
                              context,
                              quantity: orderWatch
                                      .listOfNonSystemProductsProduct[i]
                                      .quantity!
                                      .toInt() +
                                  -1,
                              type: 1,
                              id: orderWatch
                                  .listOfNonSystemProductsProduct[i].sId,
                              designId: null,
                            );
                        },
                        incrementOnTap: () {
                          orderRead.updateCartQuantitApi(
                            context,
                            quantity: orderWatch
                                    .listOfNonSystemProductsProduct[i].quantity!
                                    .toInt() +
                                1,
                            type: 1,
                            id: orderWatch
                                .listOfNonSystemProductsProduct[i].sId,
                            designId: null,
                          );
                        },
                        //status: orderWatch.nonSystemProductListStatus[i],
                        status: orderWatch.nonSystemProductListStatus[i],
                        isFromProductScreen: !homeWatch.isFromTattoo,
                      ),
                    ],
                  ],
                ),
        ],
      ),
    );
  }

  Widget totalAmountWidget() {
    return orderWatch.listOfSystemProducts.length == 0 &&
            orderWatch.listOfNonSystemProductsProduct.length == 0
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 20.w),
            color: theme.lightBlackColor,
            child: Row(
              children: [
                Text(
                  'Total',
                  style: utils.labelStyle(theme.whiteColor,
                      fontFamily: 'finalBold'),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  '${priceKey}${orderWatch.mdCartModal.cart!.first.subTotal}',
                  style: utils.xlHeadingStyle(theme.orangeColor,
                      fontFamily: 'finalBold'),
                ),
                Expanded(child: SizedBox()),
                Hero(
                  tag: 'checkout',
                  child: Container(
                    width: static.width > 550
                        ? static.width * .4
                        : static.width * .5,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    child: utils.button(
                      textSize: static.width > 550 ? 10.sp : 20.sp,
                      text: 'Checkout',
                      buttonColor: theme.orangeColor,
                      borderColor: theme.orangeColor,
                      fontFamily: 'finalBold',
                      ontap: () async {
                        await orderRead.routeFromOrderDetailUpdate(
                            value: false);

                        Navigator.pushNamed(context, route.checkOutScreenRoute);

                        //  await authRead.signInApi(context);
                      },
                      textColor: theme.whiteColor,
                      width: static.width,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

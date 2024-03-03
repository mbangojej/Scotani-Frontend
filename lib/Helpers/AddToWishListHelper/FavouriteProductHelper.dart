import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/MyCartWidget.dart';
import 'package:skincanvas/AppUtils/Widgets/MyWishListContainer.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/main.dart';

class MyWishListHelper {
  BuildContext context;

  MyWishListHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var wishListWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var wishListRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  Widget MyWishListText() {
    return utils.appBar(
      context,
      barText: 'My Wishlist',
    );
  }

  Widget myCartList() {
    return Padding(
        padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            for (int i = 0; i < wishListWatch.wishItemList.reversed.length; i++)
              GestureDetector(
                onTap: () {
                  homeRead.productDetailApi(context,
                      productID: wishListWatch.wishItemList[i].productId);
                },
                child: MyWishListWidget(
                  productName: wishListWatch.wishItemList[i].product == null
                      ? ""
                      : '${wishListWatch.wishItemList[i].product!.title.toString() ?? ''}',
                  productAttribute: wishListWatch.wishItemList[i].product ==
                          null
                      ? ""
                      : '${utils.convertHtmlToPlainText(wishListWatch.wishItemList[i].product!.shortDescription!)}',
                  productPrice: wishListWatch.wishItemList[i].product == null
                      ? ""
                      : '${priceKey}${wishListWatch.wishItemList[i].product!.price.toString() ?? 0.0}',
                  productImage: wishListWatch.wishItemList[i].product == null
                      ? ""
                      : '${wishListWatch.wishItemList[i].product!.image.toString() ?? ''}',
                  onTap: () {
                    wishListRead.makeAndRemoveWishListApi(context,
                        productID:
                            wishListWatch.wishItemList[i].productId.toString(),
                        status: false);
                  },
                ),
              ),
          ],
        ));
  }
}

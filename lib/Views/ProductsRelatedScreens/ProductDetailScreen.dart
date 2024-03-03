import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Helpers/ProductRelatedHelper/ProductDetailHelper.dart';
import 'package:skincanvas/main.dart';

class ProductDetailScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    ProductDetailHelper helper = ProductDetailHelper(context);
    var orderRead =
        navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          orderRead.resetQty();
        },
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          bottomNavigationBar: helper.bottomBar(),
          body: InternetConnectivityScreen(
            widget: SingleChildScrollView(
              child: Container(
                width: static.width,
                // height: static.height,
                child: Column(
                  children: [
                    helper.productDetailText(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          helper.cartList(),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                helper.titleText(),
                                helper.colors(),
                                helper.size(),
                                helper.specification(),
                                helper.quantity(),
                                helper.description(),
                                helper.buttons()
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                    // helper.myCartList(),
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //     child: Column(
                    //       children: [
                    //         helper.priceOfProduct(),
                    //         helper.description(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // helper.buttons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

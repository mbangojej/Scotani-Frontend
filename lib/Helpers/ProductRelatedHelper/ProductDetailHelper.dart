import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:skincanvas/Models/MDCartModal.dart';
import 'package:skincanvas/main.dart';

class ProductDetailHelper {
  BuildContext context;

  ProductDetailHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  Widget bottomBar() {
    return BottomAppBar(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        color: Colors.transparent,
        height: 60,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 86.25,
            height: 48,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  homeRead.screenIndexUpdate(index: 0);
                  Navigator.pushNamed(
                      context, route.bottomNavigationScreenRoute);
                },
                child: Image.asset(
                  'assets/Icons/home-05.png',
                  color: Color(0xFFFFFFFF),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 86.25,
            height: 48,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  homeRead.screenIndexUpdate(index: 1);
                  Navigator.pushNamed(
                      context, route.bottomNavigationScreenRoute);
                },
                child: Image.asset(
                  'assets/Icons/bag-2.png',
                  color: Color(0xFFFFFFFF),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 86.25,
            height: 48,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  homeRead.screenIndexUpdate(index: 2);
                  Navigator.pushNamed(
                      context, route.bottomNavigationScreenRoute);
                },
                child: Image.asset(
                  'assets/Icons/notification-02.png',
                  color: Color(0xFFFFFFFF),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 86.25,
            height: 48,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  homeRead.screenIndexUpdate(index: 3);
                  Navigator.pushNamed(
                      context, route.bottomNavigationScreenRoute);
                },
                child: Image.asset(
                  'assets/Icons/user-02.png',
                  color: Color(0xFFFFFFFF),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          )
        ]));
  }

  Widget productDetailText() {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      padding: EdgeInsets.all(10),
      width: static.width,
      color: theme.lightBlackColor,
      child: Row(
        children: [
          Container(
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
              iconSize: static.width > 550 ? 16.sp : 24.sp,
              // Callback function when pressed
              tooltip: 'Like', // Optional tooltip text
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Product Detail',
                style: utils.generalHeadingBold(theme.whiteColor,
                    size: static.width > 550 ? 20.sp : 26.sp,
                    fontFamily: 'finalBold'),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget myCartList() {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
//           height: static.height * .35,
//           width: static.width,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           decoration: BoxDecoration(
//             color: theme.backGroundColor,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: GestureDetector(
//             onTap: () {},
//             child: Container(
//               width: static.width,
//               decoration: BoxDecoration(
//                 color: theme.backGroundColor,
//               ),
  // child: CachedNetworkImage(
//                 imageUrl:
//                     '${homeWatch.mdProductDetailModal.data!.productImage!}',
//                 progressIndicatorBuilder: (context, url, downloadProgress) =>
//                     utils.loadingShimmer(
//                   height: static.width * .5.w,
//                   width: static.width * .5.w,
//                 ),
//                 errorWidget: (context, url, error) => utils.loadingShimmer(
//                   height: static.width * .5.w,
//                   width: static.width * .5.w,
//                 ),
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ), ///////Working
//         ),
//         SizedBox(
//           height: 15.h,
//         ),
//       ],
//     );
//   }

//   Widget description() {
//     return Container(
//       padding:
//           EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(top: 30.h),
//       width: static.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '${homeWatch.mdProductDetailModal.data!.productName!}',
//             style:
//                 utils.xlHeadingStyle(theme.whiteColor, fontFamily: 'finalBold'),
//           ),
//           SizedBox(
//             height: 8.h,
//           ),
//           Text(
//             utils.convertHtmlToPlainText(homeWatch.mdProductDetailModal.data!.productDescription!),
//             style: utils.generalHeading(theme.whiteColor.withOpacity(.8),
//                 fontFamily: 'finalBook',
//                 size: static.width > 550 ? 8.sp : 13.sp),
//           ),
//           SizedBox(
//             height: 30.h,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget priceOfProduct() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       color: theme.lightBlackColor,
//       height: static.height * .08,
//       child: Row(
//         children: [
//           Text(
//             'Price',
//             style: utils.labelStyle(theme.whiteColor, fontFamily: 'finalBold'),
//           ),
//           Expanded(child: SizedBox()),
//           Text(
//             '${priceKey}${homeWatch.mdProductDetailModal.data!.productPrice!}',
//             style: utils.xlHeadingStyle(theme.orangeColor,
//                 fontFamily: 'finalBold'),
//           ),
//         ],
//       ),
//     );
//   }

  // Widget buttons() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 15.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         // Container(
  //         //   width: static.width * .55,
  //         //   padding: EdgeInsets.symmetric(vertical: 12.h) +
  //         //       EdgeInsets.only(left: 20.w, right: 10.w),
  //         //   child: utils.button(
  //         //     textSize: static.width > 550
  //         //         ? 10.sp
  //         //         : homeWatch.mdProductDetailModal.data!.isFeatured!
  //         //             ? 15.sp
  //         //             : 18.sp,
  //         //     text: homeWatch.mdProductDetailModal.data!.isFeatured!
  //         //         ? " Remove From Wishlist"
  //         //         : 'Add to Wishlist',
  //         //     buttonColor: theme.transparentColor,
  //         //     borderColor: theme.orangeColor,
  //         //     fontFamily: 'finalBold',
  //         //     ontap: () async {
  //         //       orderRead.makeAndRemoveWishListApi(context,
  //         //           productID: homeWatch.mdProductDetailModal.data!.productID,
  //         //           status: !homeWatch.mdProductDetailModal.data!.isFeatured!);
  //         //     },
  //         //     textColor: theme.orangeColor,
  //         //     width: static.width,
  //         //   ),
  //         // ),
  //         Hero(
  //           tag: 'checkout',
  //           child: Container(
  //             width: static.width * .45,
  //             padding: EdgeInsets.symmetric(vertical: 12.h) +
  //                 EdgeInsets.only(right: 10.w),
  // child: utils.button(
  //               textSize: static.width > 550
  //                   ? 10.sp
  //                   : homeWatch.mdProductDetailModal.data!.isProductIntoCart!
  //                       ? 15.sp
  //                       : 18.sp,
  //               text: homeWatch.mdProductDetailModal.data!.isProductIntoCart!
  //                   ? 'Added into Cart'
  //                   : 'Add to Cart',
  //               buttonColor: theme.orangeColor,
  //               borderColor: theme.orangeColor,
  //               fontFamily: 'finalBold',
  //               ontap: () async {
  //                 if (homeWatch.mdProductDetailModal.data!.isProductIntoCart!) {
  //                   utils.showToast(context,
  //                       message: "Product Already into Cart");
  //                 } else {
  //                   orderRead.addToCartApi(
  //                     context,
  //                     type: 0,
  //                     systemProduct: SystemProductsSender(
  //                         productId:
  //                             homeWatch.mdProductDetailModal.data!.productID,
  //                         quantity: 1,
  //                         price: homeWatch
  //                             .mdProductDetailModal.data!.productPrice!
  //                             .toDouble(),
  //                         subTotal: homeWatch
  //                             .mdProductDetailModal.data!.productPrice!
  //                             .toDouble()),
  //                   );
  //                 }

  //                 // Navigator.pushNamed(context, route.checkOutScreenRoute);

  //                 //  await authRead.signInApi(context);
  //               },
  //               textColor: theme.whiteColor,
  //               width: static.width,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget imageContainer(imageUrl, colorCode) {
    return Container(
      width: 120,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFD9D9D9),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 120,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                utils.loadingShimmer(
                          height: 120.toDouble(),
                          width: 120.toDouble(),
                        ),
                        errorWidget: (context, url, error) =>
                            utils.loadingShimmer(
                          height: 150.toDouble(),
                          width: 120.toDouble(),
                        ),
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        orderRead.removeVariationQty(colorCode);
                      },
                      child: Center(
                        child: Image.asset(
                          "assets/Icons/trash.png",
                          color: Color(0xFFFFFFFF),
                          width: 20,
                          height: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(0xFFFF1108),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4)))),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Center(
                        child: Image.asset(
                          "assets/Icons/edit.png",
                          color: Color(0xFFFFFFFF),
                          width: 20,
                          height: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(0xFF636366),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4)))),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cartList() {
    return Column(children: [
      if (homeWatch.mdProductDetailModal.data!.variations != null &&
          homeWatch.mdProductDetailModal.data!.variations!.length > 0 &&
          homeWatch.mdProductDetailModal.data!.variations![0].values != null)
        ...homeWatch.mdProductDetailModal.data!.variations![0].values!
            .map((val) {
          return Column(
            children: [
              imageContainer(val.image.toString(), val.colorCode),
              SizedBox(
                height: 8,
              )
            ],
          );
        })
      else
        imageContainer(homeWatch.mdProductDetailModal.data!.productImage, ""),
      SizedBox(height: 8),
      Container(
        width: 120,
        height: 160,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent),
          child: Center(
            child: Image.asset(
              "assets/Icons/fluent_stack-add-24-filled.png",
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget titleText() {
    return Container(
      width: 217,
      child: Text(
        homeWatch.mdProductDetailModal.data!.productName!,
        maxLines: 3,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget colors() {
    if (homeWatch.mdProductDetailModal.data!.variations != null &&
        homeWatch.mdProductDetailModal.data!.variations!.length > 0 &&
        homeWatch.mdProductDetailModal.data!.variations![0].values != null) {
      bool firstColorSelected = false;
      String selectedColor = orderRead.selectedColor;
      return Container(
        margin: EdgeInsets.only(top: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homeWatch.mdProductDetailModal.data!.variations![0].title
                  .toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF)),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: homeWatch
                  .mdProductDetailModal.data!.variations![0].values!
                  .map((val) {
                String? hexColor = val.colorCode;
                int colorValue =
                    int.parse(hexColor!.substring(1, 7), radix: 16) +
                        0xFF000000;

                if (!firstColorSelected && selectedColor.isEmpty) {
                  orderRead.selectColor(
                      hexColor.substring(1, 7)); // Remove '#' character
                  firstColorSelected = true;
                }
                return GestureDetector(
                  onTap: () {
                    orderRead.selectColor(
                        hexColor.substring(1, 7)); // Remove '#' character
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(colorValue),
                        border:
                            orderWatch.selectedColor == hexColor.substring(1, 7)
                                ? Border.all(color: Color(0xFFFF1108), width: 2)
                                : null),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget size() {
    if (homeWatch.mdProductDetailModal.data!.variations != null &&
        homeWatch.mdProductDetailModal.data!.variations!.length > 1 &&
        homeWatch.mdProductDetailModal.data!.variations![1].values != null) {
      bool firstSizeSelected = false;
      String selectedSize = orderRead.selectedSize;
      return Container(
        margin: EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homeWatch.mdProductDetailModal.data!.variations![1].title
                  .toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: homeWatch
                  .mdProductDetailModal.data!.variations![1].values!
                  .map((val) {
                if (!firstSizeSelected && selectedSize.isEmpty) {
                  orderRead.selectSize(val.title);
                  firstSizeSelected = true;
                }
                return GestureDetector(
                  onTap: () {
                    orderRead.selectSize(val.title);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFFFFFFFF),
                        border: orderWatch.selectedSize == val.title
                            ? Border.all(color: Color(0xFFFF1108), width: 2)
                            : null),
                    child: Center(
                      child: Text(
                        val.title.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget specification() {
    return Container(
      margin: EdgeInsets.only(top: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Icons/perspective.png",
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "Specification",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFFFFF)),
          ),
          const SizedBox(
            width: 4,
          ),
          Image.asset("assets/Icons/arrow-narrow-right.png",
              width: 24, height: 24, color: Color(0xFFFFFFFF)),
        ],
      ),
    );
  }

  Widget quantity() {
    return Container(
      margin: EdgeInsets.only(top: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Qty:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF)),
          ),
          const SizedBox(
            width: 14,
          ),
          GestureDetector(
            onTap: () {
              orderRead.decrementVariationQty();
            },
            child: Image.asset(
              "assets/Icons/minus-square.png",
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Container(
            width: 38,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFFFFFF)),
            child: Center(
                child: Text(
              orderWatch.variationQuantityText(
                  // homeWatch.mdProductDetailModal.data?.productID.toString()
                  ),
              style: TextStyle(
                color: Color(0xFF0000000),
              ),
            )),
          ),
          SizedBox(
            width: 14,
          ),
          GestureDetector(
            onTap: () {
              orderRead.incrementVariationQty(
                  homeWatch.mdProductDetailModal.data!.productPrice!.toDouble(),
                  homeWatch.mdProductDetailModal.data?.productID.toString());
            },
            child: Image.asset(
              "assets/Icons/plus-square.png",
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Description:",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFFFFFF)),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 217,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFFFFFFF), width: 1),
            ),
            child: Text(
              utils.convertHtmlToPlainText(
                  homeWatch.mdProductDetailModal.data!.productDescription!),
              style: TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              print("call function");
              if (orderWatch.listOfVariation.length > 0) {
                orderRead.addToCartApi(context,
                    type: 0,
                    systemProduct: SystemProductsSender(
                      productId: homeWatch.mdProductDetailModal.data!.productID,
                      quantity: 0,
                      price: homeWatch.mdProductDetailModal.data!.productPrice!
                          .toDouble(),
                      subTotal: homeWatch
                          .mdProductDetailModal.data!.productPrice!
                          .toDouble(),
                      variationData: orderWatch.listOfVariation,
                    ));
              }
            },
            child: Container(
              width: 108,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFFFFFFFF),
              ),
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Image.asset(
                      "assets/Icons/shopping-cart-01.png",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ])),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFFF1108),
            ),
            child: Center(
                child: Text(
              "Add  Design",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            )),
          )
        ],
      ),
    );
  }
}

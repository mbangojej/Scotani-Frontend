// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/InspirationalWidgets.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDCartModal.dart';
import 'package:skincanvas/Models/MDProductModal.dart';
import 'package:skincanvas/main.dart';

class HomeFragmentHelper {
  BuildContext context;
  TabController tabController;
  ScrollController scrollController;

  HomeFragmentHelper(this.context, this.tabController, this.scrollController) {
    tabController.addListener(() async {
      if (!tabController.indexIsChanging) {
        await homeRead.updateIsFirstTime(value: 1);
        await homeRead.tabIndexUpdator(context, index: tabController.index);
      }
    });

    scrollController.addListener(() async {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        if (homeWatch.mdProductModal.data!.pagination!.pages!.toInt() >=
            homeWatch.productPage) {
          print("Selected Caetfory type ${homeWatch.productPage}");
          await homeRead.productListingApi(context,
              type: homeWatch.selectedCategoryType,
              categoryID: homeWatch.selectedCategoryID,
              title: '${homeWatch.homeSearchController.text}',
              page: homeWatch.productPage,
              isLoading: true);

          print("The page number is: ${homeWatch.productPage}");
        }

        print('scroll');
      }
    });
  }

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  var orderRead = Provider.of<OrderCheckOutWishlistController>(
      navigatorkey.currentContext!,
      listen: false);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  Widget appBar() {
    // return Consumer<GeneralController>(builder: (context, generalWatch, _) {
    return AppBar(
      backgroundColor: theme.backGroundColor,
      elevation: 0.0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: Alignment.topLeft,
        child: Row(children: [
          Image.asset(
            "assets/Icons/drawer.png",
            scale: 3.5,
          ),
          SizedBox(
            width: 10.w,
          ),
          Image.asset(
            "assets/Icons/logo_home.png",
            scale: 3,
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Image.asset(
              "assets/Icons/scotani_name.png",
              scale: 4.5,
            ),
          ),
        ]),
      ),

      ///
      /// Action
      ///

      actions: [
        InkWell(onTap: () async {
          if (homeWatch.loadingApi == false) {
            await orderRead.cartListingApi(context,
                isLoading: true, isRoute: true);
            orderRead.onCartFromHomeUpdate(value: true);
          }
        }, child: Consumer<OrderCheckOutWishlistController>(
            builder: (context, orderAndWishListWatch, _) {
          return Stack(children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: theme.whiteColor, shape: BoxShape.circle),
              child: Image.asset(
                "assets/Icons/cart1.png",
                scale: 3.5,
              ),
            ),
            if (orderAndWishListWatch.quantityOfCartProduct != 0)
              Positioned(
                right: 0.w,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: theme.orangeColor),
                  child: Center(
                    child: Text(
                      "${orderAndWishListWatch.quantityOfCartProduct == 100 ? '99+' : orderAndWishListWatch.quantityOfCartProduct}",
                      style: utils.smallLabelStyleB(theme.whiteColor),
                    ),
                  ),
                  height:
                      MediaQuery.of(navigatorkey.currentContext!).size.width >
                              550
                          ? 13.w
                          : 23.w,
                  width:
                      MediaQuery.of(navigatorkey.currentContext!).size.width >
                              550
                          ? 13.w
                          : 23.w,
                ),
              ),
          ]);
        })),
        SizedBox(
          width: 8.w,
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
              margin:
                  static.width > 500 ? EdgeInsets.all(2.w) : EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.lightGreyColor,
              ),
              child: CachedNetworkImage(
                imageUrl: generalWatch.profilePhotoValue!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
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
    );

    // Container(
    //   padding:
    //       EdgeInsets.symmetric(horizontal: 10.w) + EdgeInsets.only(top: 20.h),
    //   width: static.width,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       // Expanded(
    //       //   child: Container(
    //       //     child: Text(
    //       //       'Welcome ${generalWatch.fullNameValue}',
    //       //       style: utils.generalHeadingBold(theme.whiteColor,
    //       //           size: static.width > 550 ? 20.sp : 26.sp,
    //       //           fontFamily: 'finalBold'),
    //       //       maxLines: 2,
    //       //       overflow: TextOverflow.ellipsis,
    //       //     ),
    //       //   ),
    //       // ),
    //       Expanded(
    //         child: Row(children: [
    //           Image.asset(
    //             "assets/Icons/logo_home.png",
    //             scale: 3,
    //           ),
    //           SizedBox(
    //             width: 10.w,
    //           ),
    //           Expanded(
    //             child: Image.asset(
    //               "assets/Icons/scotani_name.png",
    //               scale: 5,
    //             ),
    //           ),
    //         ]),
    //       ),
    //       SizedBox(
    //         width: 15.w,
    //       ),
    //       Row(
    //         children: [
    //           // InkWell(
    //           //     onTap: () {
    //           //       if (homeWatch.loadingApi == false)
    //           //         orderRead.wishListApi(context);
    //           //     },
    //           //     child: Icon(
    //           //       Icons.favorite,
    //           //       size: static.width > 550 ? 22.sp : 30.sp,
    //           //       color: theme.orangeColor,
    //           //     )),
    //           // SizedBox(
    //           //   width: 8.w,
    //           // ),
    //           InkWell(onTap: () async {
    //             if (homeWatch.loadingApi == false) {
    //               await orderRead.cartListingApi(context,
    //                   isLoading: true, isRoute: true);
    //               orderRead.onCartFromHomeUpdate(value: true);
    //             }
    //           }, child: Consumer<OrderCheckOutWishlistController>(
    //               builder: (context, orderAndWishListWatch, _) {
    //             return Stack(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.symmetric(vertical: 12.h),
    //                   child: Image.asset(
    //                     "assets/Icons/cart_home.png",
    //                     width: static.width > 550 ? 20.sp : 28.sp,
    //                     height: static.width > 550 ? 20.sp : 28.sp,
    //                   ),
    //                 ),
    //                 if (orderAndWishListWatch.quantityOfCartProduct != 0)
    //                   Positioned(
    //                     right: 0.w,
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           color: theme.orangeColor),
    //                       child: Center(
    //                         child: Text(
    //                           "${orderAndWishListWatch.quantityOfCartProduct == 100 ? '99+' : orderAndWishListWatch.quantityOfCartProduct}",
    //                           style: utils.smallLabelStyleB(theme.whiteColor),
    //                         ),
    //                       ),
    //                       height: MediaQuery.of(navigatorkey.currentContext!)
    //                                   .size
    //                                   .width >
    //                               550
    //                           ? 13.w
    //                           : 23.w,
    //                       width: MediaQuery.of(navigatorkey.currentContext!)
    //                                   .size
    //                                   .width >
    //                               550
    //                           ? 13.w
    //                           : 23.w,
    //                     ),
    //                   ),
    //               ],
    //             );
    //           })),
    //           SizedBox(
    //             width: 8.w,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               FocusScope.of(context).unfocus();

    //               utils.flipCard(context);
    //             },
    //             child: Container(
    //               padding: EdgeInsets.symmetric(horizontal: 4.w),
    //               decoration: BoxDecoration(
    //                   color: theme.lightBlackColor,
    //                   shape: BoxShape.circle,
    //                   border:
    //                       Border.all(color: theme.greyColor.withOpacity(.8))),
    //               child: Container(
    //                 width: static.width > 500 ? 40.w : 45.w,
    //                 height: static.width > 500 ? 40.h : 45.h,
    //                 margin: static.width > 500
    //                     ? EdgeInsets.all(2.w)
    //                     : EdgeInsets.all(0),
    //                 clipBehavior: Clip.antiAliasWithSaveLayer,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: theme.lightGreyColor,
    //                 ),
    //                 child: CachedNetworkImage(
    //                   imageUrl: generalWatch.profilePhotoValue!,
    //                   progressIndicatorBuilder:
    //                       (context, url, downloadProgress) =>
    //                           utils.loadingShimmer(
    //                     width: 30.w,
    //                     height: 30.h,
    //                   ),
    //                   errorWidget: (context, url, error) =>
    //                       utils.loadingShimmer(
    //                     width: 30.w,
    //                     height: 30.h,
    //                   ),
    //                   fit: BoxFit.contain,
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
    // });
  }

  Widget fieldForSearch() {
    return Consumer<HomeController>(builder: (context, homeWatch, _) {
      return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: utils.inputField(
          textColor: theme.blackColor,
          placeholderColor: theme.blackColor,
          placeholder: "Browse our wide range of apparel",
          //  homeWatch.tabIndex
          // == 0
          //     ? 'Find Inspirations'
          //     : homeWatch.tabIndex == 1
          //         ? "Find Discover"
          //         : homeWatch.tabIndex == 2
          //             ? "Find Tattoos"
          //             : "Find Fashion",
          isSecure: false,
          controller: homeWatch.homeSearchController,
          maxLines: 1,
          prefixIcon: 'search',
          postfixIcon: 'remove',
          postfixClick: () {
            // Clear the text in homeSearchController
            homeWatch.homeSearchController.text = '';
            // Notify listeners about the change
            homeWatch.homeSearchController.notifyListeners();
          },
          prefixClick: () async {
            await homeRead.productListingApi(context,
                type: homeWatch.selectedCategoryType,
                title: '${homeWatch.homeSearchController.text}',
                categoryID: homeWatch.selectedCategoryID,
                isLoading: true);
          },
          prefixIconColor: theme.blackColor,
          postfixIconColor: theme.blackColor,
          preFixIconSize: static.width > 550 ? 10.w : 14.w,
          postFixIconSize: static.width > 550 ? 8.w : 10.w,
          onChange: (text) async {
            //   print("The text is"+ text.toString());
            if (text == '')
              await homeRead.productListingApi(context,
                  type: homeWatch.selectedCategoryType,
                  title: '$text',
                  categoryID: homeWatch.selectedCategoryID,
                  isLoading: true);
          },
        ),
      );
    });
  }

  tabs() {
    return Consumer<HomeController>(builder: (context, homeWatch, _) {
      return static.width > 550
          ? IgnorePointer(
              ignoring: homeWatch.loadingApi,
              child: TabBar(
                // dividerHeight: 0.0,
                dividerColor: theme.blackColor,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicator: BoxDecoration(),
                unselectedLabelColor: theme.whiteColor,
                indicatorColor: theme.blackColor,
                labelColor: theme.redColor,
                controller: tabController,

                // indicatorSize: TabBarIndicatorSize.label,
                // indicatorPadding:
                //     EdgeInsets.only(bottom: static.width > 500 ? 0.h : 8.h),
                // indicatorWeight: 1.0,
                labelStyle: TextStyle(
                    fontFamily: 'finalBold',
                    fontSize: static.width > 550 ? 12.sp : 18.sp),
                tabs: <Widget>[
                  customTab("Inspirations"),
                  customTab("Discover"),
                  // customTab("Tattoos"),
                  customTab("Fashion"),
                ],
              ),
            )
          : TabBar(
              // dividerHeight: 0.0,
              dividerColor: theme.blackColor,

              tabAlignment: TabAlignment.start,
              isScrollable: true,
              unselectedLabelColor: theme.whiteColor,

              indicatorColor: theme.blackColor,
              labelColor: theme.redColor,
              controller: tabController,
              indicator: BoxDecoration(),
              // padding: EdgeInsets.symmetric(horizontal: 2.w),
              // indicatorSize: TabBarIndicatorSize.label,
              // indicatorPadding: EdgeInsets.only(bottom: 8.h),
              // indicatorWeight: 1.0,
              labelStyle: TextStyle(
                  fontFamily: 'finalBold',
                  fontSize: static.width > 550 ? 14.sp : 22.sp),
              tabs: <Widget>[
                Tab(
                  text: "Inspiration",
                ),
                Tab(
                  text: "Discover",
                ),
                Tab(
                  text: "Tattoos",
                ),
                Tab(
                  text: "T-Shirts",
                ),
              ],
            );
    });
  }

  Widget customTab(String title) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth / 5.0;

    print("screen width ${screenWidth}");

    return Container(
      width: tabWidth,
      alignment: Alignment.center,
      child: Tab(
        child: Container(
          padding: EdgeInsets.only(
              bottom:
                  screenWidth > 500 ? 0.h : 12.h), // Adjust the value as needed
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'finalBold',
                fontSize: static.width > 550 ? 11.sp : 18.sp),
          ),
        ),
      ),
    );
  }

  Widget tabView() {
    return Consumer<HomeController>(builder: (context, homeWatch, _) {
      return TabBarView(
        physics: homeWatch.loadingApi
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          gridViewContainer(),
          gridViewContainer(),
          gridViewContainer(),
          gridViewContainer(),
        ],
      );
    });
  }

  gridViewContainer() {
    return Container(
      // height: static.height,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectCategoryWidgets(),
            SizedBox(
              height: 10.h,
            ),
            Consumer<HomeController>(builder: (context, homeWatch, _) {
              int lengthOfList = homeWatch.tabIndex == 0
                  ? homeWatch.inspirationProductList.length
                  : homeWatch.tabIndex == 1
                      ? homeWatch.discoverProductList.length
                      : homeWatch.tabIndex == 2
                          ? homeWatch.tattooProductList.length
                          : homeWatch.fashionProductList.length;

              return homeWatch.productLoading &&
                          homeWatch.productList.isEmpty ||
                      homeWatch.loadingApi
                  ? Container(
                      width: static.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 4; i++) utils.productShimmer(),
                        ],
                      ),
                    )
                  : !homeWatch.productLoading &&
                          (homeWatch.tabIndex == 0
                              ? homeWatch.inspirationProductList.isEmpty
                              : homeWatch.tabIndex == 1
                                  ? homeWatch.discoverProductList.isEmpty
                                  : homeWatch.tabIndex == 2
                                      ? homeWatch.tattooProductList.isEmpty
                                      : homeWatch.fashionProductList.isEmpty)
                      ? Container(
                          alignment: Alignment.center,
                          child: utils.noDataFound())
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                          ),
                          child: Consumer<HomeController>(
                              builder: (context, homeWatch, _) {
                            return Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                for (int i = 0; i < lengthOfList; i++) ...[
                                  buildImageCard(
                                    index: i,
                                    productDetailList: homeWatch.tabIndex == 0
                                        ? homeWatch.inspirationProductList
                                        : homeWatch.tabIndex == 1
                                            ? homeWatch.discoverProductList
                                            : homeWatch.tabIndex == 2
                                                ? homeWatch.tattooProductList
                                                : homeWatch.fashionProductList,
                                  ),
                                ]
                              ],
                            );
                          }),
                        );
            }),
            SizedBox(
              height: static.width > 500 ? 40.h : 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectCategoryWidgets({type = 0}) {
    return Consumer<HomeController>(builder: (context, homeWatch, _) {
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // controller: scrollController,
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                if (homeWatch.loadingApi) ...[
                  for (int i = 0; i < 4; i++) utils.categoriesShimmer(),
                ] else if (homeWatch.categoryList.isNotEmpty) ...[
                  for (int i = 0; i < homeWatch.categoryList.length; i++)
                    InspirationalContainer(
                        categories: homeWatch.categoryList[i],
                        index: i,
                        onTap: () {
                          print("homeWatch.tabIndex ${homeWatch.tabIndex}");
                          homeRead.selectedCategoryUpdator(
                              index: i,
                              ID: homeWatch.categoryList[i].sId.toString(),
                              type: homeWatch.tabIndex == 0
                                  ? "0"
                                  : homeWatch.tabIndex == 1
                                      ? "1"
                                      : homeWatch.tabIndex == 2
                                          ? "2"
                                          : "4");

                          homeRead.productListingApi(context,
                              categoryID: homeWatch.categoryList[i].sId,
                              title: '',
                              isLoading: false,
                              type: homeWatch.tabIndex == 0
                                  ? "0"
                                  : homeWatch.tabIndex == 1
                                      ? "1"
                                      : homeWatch.tabIndex == 2
                                          ? "2"
                                          : "4");
                        }),
                ],
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ));
    });
  }

  Widget buildImageCard({index, List<Products>? productDetailList}) {
    return GestureDetector(
      onTap: () {
        //homeRead.categoryStatusUpdate(index: index);
      },
      child: Container(
        width: static.width > 500 ? static.width * .45 : static.width * .46,
        height: static.width > 500 ? static.height * .42 : static.height * .35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: theme.transparentColor,
        ),
        margin: EdgeInsets.only(bottom: 10.h) +
            EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  homeRead.productDetailApi(context,
                      productID: productDetailList[index].sId);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      // border: Border.all(
                      //   color:
                      //       // homeWatch.categoryStatus[index]
                      //       //     ?
                      //       theme.whiteColor,
                      //   // : theme.whiteColor,
                      // ),
                      color: theme.backGroundColor),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: ClipRRect(
                      // Wrap the image with ClipRRect
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        imageUrl: '${productDetailList![index].image}',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                utils.loadingShimmer(
                          width: static.width * .25,
                          height: static.width * .25,
                        ),
                        errorWidget: (context, url, error) =>
                            utils.loadingShimmer(
                          width: static.width * .25,
                          height: static.width * .25,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ////
                  /// Product name
                  ///
                  Text(
                    '${productDetailList[index].title.toString()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: utils
                        .smallLabelStyleB(theme.whiteColor.withOpacity(.8)),
                  ),
                  SizedBox(height: 2.h),

                  ///
                  /// Price
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${priceKey}${productDetailList[index].price!}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: theme.redColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'finalBold'),
                      ),

                      ///
                      /// Heart and Cart
                      ///
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // print( homeWatch.productList[index].sId.toString());
                              orderRead.makeAndRemoveWishListApi(context,
                                  productID: homeWatch.productList[index].sId
                                      .toString(),
                                  status: !homeWatch
                                      .productList[index].isFeatured!);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color:
                                      homeWatch.productList[index].isFeatured!
                                          ? theme.blueColor.withOpacity(0.5)
                                          : theme.blueColor,
                                  borderRadius: BorderRadius.circular(8.0.r)),
                              child: Icon(
                                size: static.width > 550 ? 18.sp : 20.sp,
                                // homeWatch.productList[index].isFeatured!
                                //     ? CupertinoIcons.heart_fill
                                // :
                                CupertinoIcons.heart_fill,
                                color: homeWatch.productList[index].isFeatured!
                                    ? theme.whiteColor.withOpacity(0.5)
                                    : theme.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),

                          ///
                          /// Cart
                          ///
                          GestureDetector(
                            onTap: () {
                              // orderRead.cartProductListSelectionInitialize();
                              // Navigator.pushNamed(context, route.myCartScreenRoute);

                              if (productDetailList[index].isProductIntoCart!) {
                                utils.showToast(context,
                                    message: "Product already into cart");
                              } else {
                                orderRead.addToCartApi(
                                  context,
                                  type: 0,
                                  systemProduct: SystemProductsSender(
                                      productId: productDetailList[index].sId,
                                      quantity: 1,
                                      price: productDetailList[index].price!,
                                      subTotal:
                                          1 * productDetailList[index].price!),
                                );
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: productDetailList[index]
                                            .isProductIntoCart!
                                        ? theme.redColor.withOpacity(.5)
                                        : theme.redColor,
                                    borderRadius: BorderRadius.circular(8.0.r)),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 20.sp,
                                  color: productDetailList[index]
                                          .isProductIntoCart!
                                      ? theme.whiteColor.withOpacity(0.7)
                                      : theme.whiteColor,
                                )
                                // ? Image.asset(
                                //     'assets/Icons/cartFilled.png',
                                //     height: static.width > 550 ? 20.w : 26.w,
                                //     width: static.width > 550 ? 20.w : 26.w,
                                //   )
                                // : Image.asset(
                                //     'assets/Icons/cart.png',
                                //     height: static.width > 550 ? 26.w : 35.w,
                                //     width: static.width > 550 ? 26.w : 35.w,
                                //   ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDCartModal.dart';
import 'package:skincanvas/main.dart';

class PlaceOrderHelper {
  BuildContext context;

  PlaceOrderHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  final ExpansionTileController controller = ExpansionTileController();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var orderAndWishListRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();
  var orderAndWishListWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();

  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget placeOrderText() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 4.w) + EdgeInsets.only(top: 8.h),
      // margin: EdgeInsets.symmetric(vertical: 5.h),
      width: static.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'Place Order',
            style: utils.generalHeadingBold(theme.whiteColor,
                size: static.width > 550 ? 18.sp : 24.sp,
                fontFamily: 'finalBold'),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: theme.whiteColor,
              ),
              // Icon to display
              onPressed: () {
                if (!homeWatch.isFromTattoo) {
                  orderAndWishListRead.updateIsExpandDesignImprint(
                      isBackButton: true);
                }
                Navigator.pop(context);
              },
              // Callback function when pressed
              tooltip: 'Like', // Optional tooltip text
            ),
          ),
        ],
      ),
    );
  }

  Widget designPrompt() {
    return

        //   Container(
        //   margin: EdgeInsets.symmetric(vertical: 12.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         margin: EdgeInsets.only(left: 20.w),
        //         child: Text(
        //           'Price',
        //           style: utils.xHeadingStyle(theme.whiteColor,
        //               fontFamily: 'finalBold'),
        //         ),
        //       ),
        //       Column(
        //         children: [
        //           Stack(
        //             children: [
        //               Row(
        //                 children: [
        //                   if (homeWatch.selectableTattoosAndGraphicList.length >= 1)
        //                     Stack(
        //                       alignment: Alignment.center,
        //                       children: [
        //                         GestureDetector(
        //                           onTap: () {
        //                             print("The print is 1");
        //                           },
        //                           child: Container(
        //                             padding: EdgeInsets.symmetric(horizontal: 3.w),
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               border: Border.all(color: theme.whiteColor),
        //                             ),
        //                             child: Container(
        //                               width: 100.w,
        //                               height: 100.h,
        //                               clipBehavior: Clip.antiAliasWithSaveLayer,
        //                               decoration: BoxDecoration(
        //                                 shape: BoxShape.circle,
        //                                 color: theme.lightGreyColor,
        //                               ),
        //                               child: FractionallySizedBox(
        //                                   alignment: Alignment.center,
        //                                   widthFactor: 0.8,
        //                                   heightFactor: 0.8,
        //                                   child: /* Image.asset(
        //                                 orderAndWishListWatch.isProductScreen
        //                                     ? 'assets/Images/shirtLogo.png'
        //                                     : 'assets/Images/Tattoo.png',
        //                                 color: homeWatch.imageColor,
        //                                 fit: BoxFit.contain,
        //                               ),*/
        //
        //                                       Image.memory(
        //                                           homeWatch
        //                                                   .selectableTattoosAndGraphicList[
        //                                               0],
        //                                           fit: BoxFit.contain,
        //                                           color: homeWatch.createTattooDesignSelection[
        //                                                       0] &&
        //                                                   homeWatch.imageColorList[
        //                                                           0] !=
        //                                                       Color(0xffFFFFFF)
        //                                               ? homeWatch.imageColorList[0]
        //                                               : null)
        //                                   //Image.network(homeWatch.selectableTattoosAndGraphicList[0],fit: BoxFit.contain,color: homeWatch.imageColorList[0])
        //                                   ),
        //                             ),
        //                           ),
        //                         ),
        //                         homeWatch.selectableTattoosAndGraphicList.length ==
        //                                 3
        //                             ? Container(
        //                                 width: 100.w,
        //                                 height: 100.h,
        //                                 decoration: BoxDecoration(
        //                                   shape: BoxShape.circle,
        //                                   color: Colors.black.withOpacity(0.3), // Black overlay with opacity 0.8
        //                                 ),
        //                               )
        //                             : Container(),
        //                       ],
        //                     ),
        //                   SizedBox(
        //                     width: 20.w,
        //                   ),
        //                   if (homeWatch.selectableTattoosAndGraphicList.length >= 2)
        //                     Stack(
        //                       alignment: Alignment.center,
        //                       children: [
        //                         GestureDetector(
        //                           onTap: () {
        //                             print("The print is 2");
        //                           },
        //                           child: Container(
        //                             padding: EdgeInsets.symmetric(horizontal: 3.w),
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               border: Border.all(color: theme.whiteColor),
        //                             ),
        //                             child: Container(
        //                               width: 100.w,
        //                               height: 100.h,
        //                               clipBehavior: Clip.antiAliasWithSaveLayer,
        //                               decoration: BoxDecoration(
        //                                 shape: BoxShape.circle,
        //                                 color: theme.lightGreyColor,
        //                               ),
        //                               child: FractionallySizedBox(
        //                                   alignment: Alignment.center,
        //                                   widthFactor: 0.8,
        //                                   heightFactor: 0.8,
        //                                   child: Image.memory(
        //                                       homeWatch
        //                                               .selectableTattoosAndGraphicList[
        //                                           1],
        //                                       fit: BoxFit.contain,
        //                                       color:
        //                                           homeWatch.createTattooDesignSelection[
        //                                                       0] &&
        //                                                   homeWatch.imageColorList[
        //                                                           1] !=
        //                                                       Color(0xffFFFFFF)
        //                                               ? homeWatch.imageColorList[1]
        //                                               : null)
        //                                   //Image.network(homeWatch.selectableTattoosAndGraphicList[1],fit: BoxFit.contain,color: homeWatch.imageColorList[1])
        //                                   ),
        //                             ),
        //                           ),
        //                         ),
        //
        //
        //                         homeWatch.selectableTattoosAndGraphicList.length == 3
        //                             ? Container(
        //                                 width: 100.w,
        //                                 height: 100.h,
        //                                 decoration: BoxDecoration(
        //                                   shape: BoxShape.circle,
        //                                   color: Colors.black.withOpacity(
        //                                       0.3), // Black overlay with opacity 0.8
        //                                 ),
        //                               )
        //                             : Container(),
        //                       ],
        //                     ),
        //                 ],
        //               ),
        //               if (homeWatch.selectableTattoosAndGraphicList.length >= 3)
        //                 Positioned(
        //                   left: 0.w,
        //                   top: 0.h,
        //                   right: 0.w,
        //                   bottom: 0.h,
        //                   child: GestureDetector(
        //                     onTap: () {
        //                       print("The print is 3");
        //                     },
        //                     child: Container(
        //                       padding: EdgeInsets.symmetric(horizontal: 3.w),
        //                       decoration: BoxDecoration(
        //                         color: theme.transparentColor,
        //                         shape: BoxShape.circle,
        //                         border: Border.all(color: theme.whiteColor),
        //                       ),
        //                       child: Padding(
        //                         padding: EdgeInsets.all(3.w),
        //                         // Adjust the padding value as needed
        //                         child: Container(
        //                           width: 115.w,
        //                           height: 115.h,
        //                           clipBehavior: Clip.antiAliasWithSaveLayer,
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                             color: theme.lightGreyColor,
        //                           ),
        //                           child: Padding(
        //                             padding: EdgeInsets.all(8.w),
        //                             child: FractionallySizedBox(
        //                                 alignment: Alignment.center,
        //                                 widthFactor: 0.8,
        //                                 heightFactor: 0.8,
        //                                 child:
        //
        //                                     Image.memory(
        //                                         homeWatch
        //                                                 .selectableTattoosAndGraphicList[
        //                                             2],
        //                                         fit: BoxFit.contain,
        //                                         color:
        //                                             homeWatch.createTattooDesignSelection[
        //                                                         0] &&
        //                                                     homeWatch.imageColorList[
        //                                                             2] !=
        //                                                         Color(0xffFFFFFF)
        //                                                 ? homeWatch
        //                                                     .imageColorList[2]
        //                                                 : null)
        //
        //                                 //Image.network(homeWatch.selectableTattoosAndGraphicList[2],fit: BoxFit.contain,color: homeWatch.imageColorList[2],)
        //                                 ),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 10.h,
        //           ),
        //           Text(
        //             orderAndWishListWatch.isProductScreen
        //                 ? homeWatch.productDesireTextController.text
        //                 : homeWatch.desireTextController.text,
        //             style: utils.headingStyle(theme.whiteColor),
        //           ),
        //         ],
        //       ),
        //       Stack(
        //         alignment: Alignment.center,
        //         children: [
        //           Image.asset(
        //             'assets/Icons/priceTag.png',
        //             width: 56.w,
        //           ),
        //           Text(
        //             '\$${homeWatch.totalPrice == 0.0 ? homeWatch.tattoosPriceList.reduce((value, element) => value + element) : homeWatch.totalPrice.toString()}',
        //             textAlign: TextAlign.center,
        //             style: utils.smallLabelStyleB(theme.orangeColor,
        //                 fontFamily: 'finalBold'),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // );

        Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Price',
                  style: utils.xHeadingStyle(theme.whiteColor,
                      fontFamily: 'finalBold'),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/Icons/priceTag.png',
                    width: 70.w,
                  ),
                  // Text(
                  //   '\$${homeWatch.totalPrice == 0.0 ? homeWatch.tattoosPriceList.reduce((value, element) => value + element) : homeWatch.totalPrice.toString()}',
                  //   textAlign: TextAlign.center,
                  //   style: utils.smallLabelStyleB(theme.orangeColor,
                  //       fontFamily: 'finalBold'),
                  // ),

                  Container(
                    width: 40.w,
                    child: FittedBox(
                      child: Text(
                        '${priceKey}${homeWatch.totalPrice.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: utils.labelStyleB(theme.orangeColor,
                            fontFamily: 'finalBold'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          homeWatch.isFromTattoo
              ? SizedBox(
                  height: 5.h,
                )
              : SizedBox(),
          Container(
            height: 160.h,
            width: static.width,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    if (homeWatch.isFromTattoo) ...[
                      for (int i = 0;
                          i < homeWatch.selectableTattoosAndGraphicList.length;
                          i++)
                        Container(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (homeWatch.isFromTattoo)
                                    orderAndWishListRead
                                        .placeOrderSelectedImageUpdate(
                                            index: i);
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: theme.whiteColor),
                                  ),
                                  child: Container(
                                    width: homeWatch.isFromTattoo
                                        ? orderAndWishListWatch
                                                .placeOrderSelectedImageList[i]
                                            ? 110.w
                                            : 95.w
                                        : 95.w,
                                    height: homeWatch.isFromTattoo
                                        ? orderAndWishListWatch
                                                .placeOrderSelectedImageList[i]
                                            ? 110.h
                                            : 95.h
                                        : 95.h,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: homeWatch.isFromTattoo
                                          ? orderAndWishListWatch
                                                  .placeOrderSelectedImageList[i]
                                              ? theme.lightGreyColor
                                              : theme.midGreyColor
                                          : theme.whiteColor,
                                    ),
                                    child: FractionallySizedBox(
                                        alignment: Alignment.center,
                                        widthFactor: 0.8,
                                        heightFactor: 0.8,
                                        child:
                                            // Image.memory(
                                            //     homeWatch.selectableTattoosAndGraphicList[i],
                                            //     fit: BoxFit.contain,
                                            //     color:
                                            //         // homeWatch.isIncreaseTextSize &&
                                            //         //         homeWatch.imageColorList[
                                            //         //                 0] !=
                                            //         //             Color(0xffFFFFFF)
                                            //         //     ? homeWatch.imageColorList[0]
                                            //         //     :
                                            //         null)
                                            Image.network(
                                          '${homeWatch.selectableTattoosAndGraphicList[i]}',
                                          color: null,
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ] else ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: theme.whiteColor),
                              ),
                              child: Container(
                                width: 155.w,
                                height: 155.h,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.blackColor,
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  widthFactor: 0.8,
                                  heightFactor: 0.8,
                                  // child: Image.memory(
                                  //   homeWatch.previewFinalImage!,
                                  //   color: null,
                                  //   fit: BoxFit.contain,
                                  // ),
                                  child: Image.network(
                                    "${homeWatch.selectedProduct!.image}",
                                    color: null,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          Text(
            !homeWatch.isFromTattoo
                ? homeWatch.productDesireTextController.text
                : homeWatch.desireTextController.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: utils.xlHeadingStyleB(homeWatch.textColor),
          ),
        ],
      ),
    );
  }

  Widget selectBodyArea() {
    return Expanded(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 12.w) + EdgeInsets.only(top: 5.h),
        decoration: BoxDecoration(
          color: theme.backGroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !homeWatch.isFromTattoo
                  ? SizedBox(
                      height: 10.h,
                    )
                  : SizedBox(),
              !homeWatch.isFromTattoo ? selectColor() : Container(),

              homeWatch.isFromTattoo ? SizedBox() : selectSize(),

              SizedBox(
                height: 10.h,
              ),

              homeWatch.isFromTattoo
                  ? orderAndWishListWatch.isExpand
                      ? SizedBox()
                      : setQuantity()
                  : selectDesignImprint(),

              !orderAndWishListWatch.isExpandDesignImprint
                  ? SizedBox()
                  : SizedBox(
                      height: 12.h,
                    ),

              if (homeWatch.isFromTattoo) selectBodyPart(),

              // if(orderAndWishListWatch.isExpandDesignImprint && !homeWatch.isFromTattoo)
              //      Column(
              //        children: [
              //          SizedBox(
              //            height: 10.h,
              //          ),
              //          Align(
              //              alignment: Alignment.center,
              //              child: Container(
              //                width: 90.w,
              //                child: Divider(
              //                  color: theme.orangeColor,
              //                ),
              //              ),
              //            ),
              //
              //          SizedBox(height: 5.h,),
              //        ],
              //      ),

              // wishListAndCartButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectSize() {
    return homeWatch.isFromTattoo
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              // Rounded border radius
              child: ExpansionTile(
                controller: controller,
                onExpansionChanged: (value) {
                  orderAndWishListWatch.updateIsExpand();
                },
                title: orderAndWishListWatch.isExpand
                    ? SizedBox()
                    : Text(
                        'Select the size',
                        style: utils.labelStyle(theme.midGreyColor),
                      ),
                backgroundColor: theme.lightBlackColor,
                collapsedBackgroundColor: theme.lightBlackColor,
                iconColor: theme.midGreyColor,
                collapsedIconColor: theme.midGreyColor,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          sizeContainer(width: '2', height: '4'),
                          sizeContainer(width: '3', height: '6'),
                          sizeContainer(width: '4', height: '7'),
                          sizeContainer(width: '4', height: '8'),
                          sizeContainer(width: '5', height: '9'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            width: static.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Product Size',
                  style: utils.xHeadingStyleB(theme.whiteColor),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0;
                          i <
                              homeWatch
                                  .selectedProduct!.attributes![1].size!.length;
                          i++) ...[
                        sizeContainer(
                            name:
                                '${homeWatch.selectedProduct!.attributes![1].size![i].value}',
                            status: homeWatch.sizesActivationList[i]),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget selectDesignImprint() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
      width: static.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Design Imprint',
            style: utils.xHeadingStyleB(theme.whiteColor),
          ),
          SizedBox(
            height: 15.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Container(
              padding: EdgeInsets.zero, // Remove any padding
              child: ExpansionTile(
                controller: controller,
                onExpansionChanged: (value) {
                  print("value${value}");
                  orderAndWishListRead.updateIsExpandDesignImprint(
                      value: value);
                },
                title: Text(
                  !orderAndWishListWatch.isExpandDesignImprint
                      ? homeWatch.selectedDesignImprint != ''
                          ? homeWatch.selectedDesignImprint
                          : 'Select Imprint Type'
                      : 'Select Imprint Type',
                  style: utils.headingStyle(
                    !orderAndWishListWatch.isExpandDesignImprint
                        ? homeWatch.selectedDesignImprint != ''
                            ? theme.orangeColor
                            : theme.midGreyColor
                        : theme.midGreyColor,
                  ),
                ),
                backgroundColor: theme.lightBlackColor,
                collapsedBackgroundColor: theme.lightBlackColor,
                iconColor: theme.midGreyColor,
                collapsedIconColor: theme.midGreyColor,
                children: <Widget>[
                  Builder(builder: (BuildContext context) {
                    return Container(
                      height: 140.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i <
                                    homeWatch.mdDesignImprint
                                        .mdDesignImprintData!.length;
                                i++)
                              designImprintSelectionContainer(
                                text:
                                    '${homeWatch.mdDesignImprint.mdDesignImprintData![i].title}',
                                status: homeWatch.selectDesignImprint[i],
                                onTap: () {
                                  homeRead.selectDesignImprintUpdate(
                                    index: i,
                                    price: homeWatch.mdDesignImprint
                                        .mdDesignImprintData![i].price,
                                  );
                                  ExpansionTileController.of(context)
                                      .collapse();
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget designImprintSelectionContainer({text, status = false, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: utils
              .headingStyle(status ? theme.orangeColor : theme.lightGreyColor),
        ),
      ),
    );
  }

  Widget sizeContainer({name = '', size = '', width, height, status}) {
    return Container(
      height: 45.h,
      width: 50.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        right: 10.w,
      ),
      decoration: BoxDecoration(
        color: status ? theme.orangeColor : theme.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: homeWatch.isFromTattoo
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Images/horizontalLine.png',
                      height: 15.h,
                      width: 15.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'W:$width',
                        style: utils.labelStyle(theme.blackColor,
                            fontFamily: 'finalBold'),
                        children: <TextSpan>[
                          TextSpan(
                              text: '"',
                              style: utils.labelStyle(theme.orangeColor,
                                  fontFamily: 'finalBold')),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Images/verticalLine.png',
                      height: 12.h,
                      width: 12.w,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'H:$height',
                        style: utils.labelStyle(theme.blackColor,
                            fontFamily: 'finalBold'),
                        children: <TextSpan>[
                          TextSpan(
                              text: '"',
                              style: utils.labelStyle(theme.orangeColor,
                                  fontFamily: 'finalBold')),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              name,
              style: utils.xHeadingStyleB(
                  status ? theme.whiteColor : theme.orangeColor),
            ),
    );
  }

  Widget selectColor() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
      width: static.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Product Color',
            style: utils.xHeadingStyleB(theme.whiteColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: static.width,
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (int i = 0;
                    i <
                        homeWatch
                            .mdColorFromSizeModal.colorFromSizeDataList!.length;
                    i++)
                  homeWatch.mdColorFromSizeModal.colorFromSizeDataList![i]
                                  .color ==
                              '' ||
                          homeWatch.mdColorFromSizeModal
                                  .colorFromSizeDataList![i].color ==
                              null
                      ? SizedBox()
                      : colorBox(
                          color: utils.hexToColor(homeWatch.mdColorFromSizeModal
                              .colorFromSizeDataList![i].color
                              .toString()),
                          index: i,
                        ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget colorBox({color, index}) {
    return Container(
      padding: index == homeWatch.selectedProductColorImageIndex
          ? EdgeInsets.all(2.w)
          : null,
      margin: EdgeInsets.symmetric(
            vertical: 10.h,
          ) +
          EdgeInsets.only(right: 40.w),
      decoration: BoxDecoration(
        border: index == homeWatch.selectedProductColorImageIndex
            ? Border.all(color: theme.whiteColor)
            : null,
        shape: BoxShape.circle,
      ),
      child: Container(
        alignment: Alignment.center,
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget setQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            orderAndWishListRead.updateDecrementAndIncrement(
              decrement: true,
              increment: false,
            );

            //  homeRead.calculatePriceByQuantity(quantity: homeWatch.placeOrderDataList[orderAndWishListWatch.placeOrderSelectedImageIndex].quantity ,index: orderAndWishListWatch.placeOrderSelectedImageIndex );
            homeRead.calculatePriceByQuantity();
            for (int i = 0; i < homeWatch.placeOrderDataList.length; i++)
              print(
                  'orderlist Length ${homeWatch.placeOrderDataList[i].quantity}');
          },
          child: Container(
            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
              color: theme.lightBlackColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: orderAndWishListWatch.isDecrement
                    ? theme.orangeColor
                    : theme.midGreyColor,
              ),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.minus,
                color: orderAndWishListWatch.isDecrement
                    ? theme.orangeColor
                    : theme.midGreyColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Container(
          height: 50.h,
          width: 140.w,
          decoration: BoxDecoration(
            color: theme.lightBlackColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              homeWatch
                  .placeOrderDataList[
                      orderAndWishListWatch.placeOrderSelectedImageIndex]
                  .quantity
                  .toString(),
              style: utils.labelStyleB(theme.orangeColor),
            ),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        GestureDetector(
          onTap: () {
            orderAndWishListRead.updateDecrementAndIncrement(
              decrement: false,
              increment: true,
            );

            //homeRead.calculatePriceByQuantity(quantity: homeWatch.placeOrderDataList[orderAndWishListWatch.placeOrderSelectedImageIndex].quantity ,index: orderAndWishListWatch.placeOrderSelectedImageIndex );

            homeRead.calculatePriceByQuantity();
          },
          child: Container(
            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
              color: theme.lightBlackColor,
              shape: BoxShape.circle,
              border: Border.all(
                  color: orderAndWishListWatch.isIncrement
                      ? theme.orangeColor
                      : theme.midGreyColor),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.add,
                color: orderAndWishListWatch.isIncrement
                    ? theme.orangeColor
                    : theme.midGreyColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectBodyPart() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'L-Arm',
          image: 'assets/Images/BodyParts/l-arm.png',
          imageColor: homeWatch.createTattooBodySelection[0]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[0]
              ? static.width * .09
              : static.width * .08,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[0],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 0);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'R-Arm',
          image: 'assets/Images/BodyParts/r-arm.png',
          imageColor: homeWatch.createTattooBodySelection[1]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[1]
              ? static.width * .10
              : static.width * .09,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[1],
          onTap: () {
            //  homeRead.createTattooBodySelectionUpdate(index: 1);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'Chest',
          image: 'assets/Images/BodyParts/chest.png',
          imageColor: homeWatch.createTattooBodySelection[2]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[2]
              ? static.width * .11
              : static.width * .1,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[2],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 2);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'Neck',
          image: 'assets/Images/BodyParts/neck.png',
          imageColor: homeWatch.createTattooBodySelection[3]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[3]
              ? static.width * .17
              : static.width * .15,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[3],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 3);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'Back',
          image: 'assets/Images/BodyParts/back.png',
          imageColor: homeWatch.createTattooBodySelection[4]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[4]
              ? static.width * .11
              : static.width * .1,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[4],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 4);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'L-Leg',
          image: 'assets/Images/BodyParts/l-leg.png',
          imageColor: homeWatch.createTattooBodySelection[5]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[5]
              ? static.width * .065
              : static.width * .055,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[5],
          onTap: () {
            //homeRead.createTattooBodySelectionUpdate(index: 5);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'R-Leg',
          image: 'assets/Images/BodyParts/r-leg.png',
          imageColor: homeWatch.createTattooBodySelection[6]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[6]
              ? static.width * .065
              : static.width * .055,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[6],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 6);
          },
        ),
        utils.categorySelectionContainer(
          isNetwork: false,
          height: static.width * .19,
          width: static.width * .19,
          text: 'Wrist',
          image: 'assets/Images/BodyParts/wrist.png',
          imageColor: homeWatch.createTattooBodySelection[7]
              ? theme.whiteColor
              : theme.midLightGreyColor,
          imageSize: homeWatch.createTattooBodySelection[7]
              ? static.width * .095
              : static.width * .08,
          textSize: 12.0.sp,
          isSelect: homeWatch.createTattooBodySelection[7],
          onTap: () {
            // homeRead.createTattooBodySelectionUpdate(index: 7);
          },
        ),
      ],
    );
  }

  Widget CartButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: theme.backGroundColor,
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 90.w,
              child: Divider(
                color: theme.orangeColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // orderAndWishListRead.addToCartApi(
                      //   context,
                      //   type: 1,
                      //   nonSystemProduct: NonSystemProducts(
                      //     productId: null,
                      //     variationId: null,
                      //     designs: [
                      //       for(int i=0;i<homeWatch.selectableTattoosAndGraphicList.length;i++)
                      //         Designs(
                      //           prompt: '${homeWatch.designPromptController.text}',
                      //           image: /*"${homeWatch.selectableTattoosAndGraphicList[i]}",*/ "https://res.cloudinary.com/dn5nxxh9f/image/upload/v1694502030/178-1789705_tribal-tattoo-tribal-spider-tattoo-designs-removebg-preview_d5j3md.png",
                      //           size:  homeWatch.placeOrderDataList[i].productID,
                      //           price: homeWatch.placeOrderDataList[i].productPrice!.toDouble(),
                      //           quantity: homeWatch.placeOrderDataList[i].quantity,
                      //         )
                      //     ],
                      //     quantity: homeWatch.totalQuantity,
                      //     price: homeWatch.totalPrice,
                      //     color:  homeWatch.placeOrderDataList[0].color,
                      //     bodyPart:  homeWatch.placeOrderDataList[0].bodyPart,
                      //     subTotal: homeWatch.totalPrice,
                      //   ),
                      //   promotionalID: null,
                      //   subTotal:homeWatch.totalPrice ,
                      //   taxTotal: 0.0 ,
                      //   discountTotal:0.0 ,
                      //   grandTotal: homeWatch.totalPrice,
                      // );

                      if (homeWatch.selectedDesignImprint == '' &&
                          !homeWatch.isFromTattoo) {
                        utils.showToast(context,
                            message: 'Please select an imprint type');
                      } else {
                        await orderAndWishListRead.routeFromOrderDetailUpdate(
                            value: false);
                        await generalRead.updateRestrictUserNavigation(
                            value: true);

                        EasyLoading.show(
                          status: 'Adding product to cart',
                        );

                        await homeRead.addToCartFromServerURLGenerator(context);

                        if (homeWatch.isFromTattoo) {
                          orderAndWishListRead.addToCartApi(
                            context,
                            type: 1,
                            designs: [
                              for (int i = 0;
                                  i <
                                      homeWatch.selectableTattoosAndGraphicList
                                          .length;
                                  i++)
                                NonSystemDesigns(
                                  prompt:
                                      '${homeWatch.designPromptController.text}',
                                  image:
                                      "${homeWatch.addToCartImagesFromServer[i]}",

                                  //image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsE69BU-rA_Q49Y2vJBsGaDSdEgJCGzbIZ1Q&usqp=CAU",

                                  size:
                                      homeWatch.placeOrderDataList[i].productID,
                                  price: homeWatch
                                      .tattoosPriceListAndData[i].price!
                                      .toDouble(),
                                  quantity:
                                      homeWatch.placeOrderDataList[i].quantity,
                                  desireText: homeWatch
                                          .desireTextController.text.isNotEmpty
                                      ? homeWatch.desireTextController.text
                                      : "",
                                  desireTextColorCode: homeWatch
                                          .desireTextController.text.isNotEmpty
                                      ? homeWatch.textColor != null
                                          ? '${AppUtils().colorToHex(homeWatch.textColor!)}'
                                          : ''
                                      : null,
                                  desireTextSizeGroup: homeWatch
                                          .desireTextController.text.isNotEmpty
                                      ? '${homeRead.getTextSizeGroupId()}'
                                      : null,
                                ),
                            ],
                            quantity: homeWatch.totalQuantity,
                            price: homeWatch.totalPrice,
                            color: homeWatch.placeOrderDataList[0].color,
                            bodyPart: homeWatch.placeOrderDataList[0].bodyPart,
                            subTotal: homeWatch.totalPrice,
                            isRoute: true,
                          );
                        } else {
                          orderAndWishListRead.addToCartApi(
                            context,
                            type: 1,
                            designs: [
                              for (int i = 0; i < homeWatch.selectableTattoosAndGraphicList.length; i++)
                                NonSystemDesigns(
                                  prompt:
                                      '${homeWatch.productDesirePromptController.text}',
                                  image:
                                      "${homeWatch.addToCartImagesFromServer[i]}",
                                  // image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFZzWbah0H-UnQCs5YD-duREWfHVVvwUCzBQ&usqp=CAU",
                                  size:
                                      homeWatch.placeOrderDataList[i].productID,
                                  price: homeWatch
                                      .tattoosPriceListAndData[i].price!
                                      .toDouble(),
                                  quantity:
                                      homeWatch.placeOrderDataList[i].quantity,
                                  desireText: homeWatch
                                          .productDesireTextController
                                          .text
                                          .isNotEmpty
                                      ? '${homeWatch.productDesireTextController.text}'
                                      : "",
                                  desireTextColorCode: homeWatch
                                          .productDesireTextController
                                          .text
                                          .isNotEmpty
                                      ? homeWatch.textColor != null
                                          ? '${AppUtils().colorToHex(homeWatch.textColor!)}'
                                          : ''
                                      : null,
                                  desireTextSizeGroup: homeWatch
                                          .productDesireTextController
                                          .text
                                          .isNotEmpty
                                      ? '${homeRead.getTextSizeGroupId()}'
                                      : null,
                                ),
                            ],
                            productID:
                                homeWatch.selectedProduct!.sId.toString(),
                            variationID: homeWatch
                                .mdVariationModal.mdVariationData!.variationId
                                .toString(),
                            productImage: homeWatch.selectedProduct!.image,
                            quantity: 1,
                            price: homeWatch
                                .mdVariationModal.mdVariationData!.price!
                                .toInt(),
                            color: 0,
                            bodyPart: 0,
                            subTotal: homeWatch.totalPrice,
                            imprintID: homeWatch.selectImprintDataDetail.sId,
                            imprintPrice:
                                homeWatch.selectImprintDataDetail.price,
                            isRoute: true,
                          );
                        }

                        orderAndWishListRead.onCartFromHomeUpdate(value: false);
                      }
                    },
                    child: Container(
                      height: static.width > 550 ? 40.h : 45.h,
                      width: static.width > 550 ? 40.w : 45.w,
                      decoration: BoxDecoration(
                        color: theme.orangeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.orangeColor),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Images/shoppingBasket.png',
                          height: static.width > 550 ? 20.h : 25.h,
                          width: static.width > 550 ? 20.w : 25.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  !orderAndWishListWatch.isExpandDesignImprint
                      ? SizedBox()
                      : SizedBox(
                          height: 3.h,
                        ),
                  Text(
                    'Add to Cart',
                    style: utils.labelStyle(theme.midGreyColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

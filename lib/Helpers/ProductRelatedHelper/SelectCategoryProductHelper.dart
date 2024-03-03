import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/InspirationalWidgets.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDHomeCategoryModal.dart';
import 'package:skincanvas/Models/MDProductModal.dart';
import 'package:skincanvas/main.dart';

class SelectCategoryHelper {
  BuildContext context;
  ScrollController scrollController;

  SelectCategoryHelper(this.context, this.scrollController) {
    bool isLoading = false;

    scrollController.addListener(() async {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        if (homeWatch.mdProductModal.data!.pagination!.pages!.toInt() >=
            homeWatch.configurablePage) {
          await homeRead.productListingApi(context,
              type: homeWatch.selectedConfigurableCategoryType,
              categoryID: homeWatch.selectedConfigurableCategoryID,
              title: '',
              page: homeWatch.configurablePage,
              isLoading: false,
              isLoadingFromConfigurable: true);

          print("The page number is: ${homeWatch.configurablePage}");
        }

        print('scroll');
      }
    });
  }

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();
  var wishListRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  Widget selectCategoryText() {
    return utils.appBar(
      context,
      barText: 'Magic!',
    );
  }

  SelectionCategoryWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      height: static.width * .32,
      child: homeWatch.configureDataList.length == 3
          ? Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (int i = 0;
                    i < homeWatch.configureDataList.length;
                    i++) ...[
                  utils.categorySelectionContainer(
                      text: '${homeWatch.configureDataList[i].name}',
                      image: '${homeWatch.configureDataList[i].image}',
                      imageColor: theme.transparentColor,
                      isSelect: homeWatch.selectConfigurableCategoriesStatus[i],
                      width: static.width > 550
                          ? static.width * .22
                          : static.width * .26,
                      height: static.width > 550
                          ? static.width * .22
                          : static.width * .26,
                      imageSize: static.width * .15,
                      textSize: static.width > 550 ? 8.sp : 12.sp,
                      isFromCreateProduct: true,
                      onTap: () async {
                        homeRead.selectConfigurableCategoriesStatusUpdate(
                            index: i);
                        homeRead.productListingApi(context,
                            categoryID: homeWatch
                                .configureDataList[i].subCategories![0].sId,
                            title: '',
                            type: "3",
                            isLoading: false,
                            isLoadingFromConfigurable: true);
                        await homeRead.selectedCategoryForConfigurableUpdator(
                            ID: homeWatch
                                .configureDataList[i].subCategories![0].sId,
                            type: '3');
                      }),
                ],
              ],
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0;
                    i < homeWatch.configureDataList.length;
                    i++) ...[
                  utils.categorySelectionContainer(
                      text: '${homeWatch.configureDataList[i].name}',
                      image: '${homeWatch.configureDataList[i].image}',
                      imageColor: theme.transparentColor,
                      isSelect: homeWatch.selectConfigurableCategoriesStatus[i],
                      width: static.width > 550
                          ? static.width * .22
                          : static.width * .26,
                      height: static.width > 550
                          ? static.width * .12
                          : static.width * .26,
                      imageSize: static.width * .15,
                      textSize: static.width > 550 ? 8.sp : 12.sp,
                      isFromCreateProduct: true,
                      onTap: () async {
                        homeRead.selectConfigurableCategoriesStatusUpdate(
                            index: i);
                        homeRead.productListingApi(context,
                            categoryID: homeWatch
                                .configureDataList[i].subCategories![0].sId,
                            title: '',
                            type: "3",
                            isLoading: false,
                            isLoadingFromConfigurable: true);
                        await homeRead.selectedCategoryForConfigurableUpdator(
                            ID: homeWatch
                                .configureDataList[i].subCategories![0].sId,
                            type: '3');
                      }),
                ],
              ],
            ),
    );
  }

  subCategoriesAndProducts() {
    return Container(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              height: static.width * .35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int j = 0;
                      j <
                          homeWatch
                              .configureDataList[
                                  homeWatch.configurableCategoryIndex]
                              .subCategories!
                              .length;
                      j++)
                    InspirationalContainer(
                      categories: Categories(
                          image: homeWatch
                              .configureDataList[
                                  homeWatch.configurableCategoryIndex]
                              .subCategories![j]
                              .image,
                          name: homeWatch
                              .configureDataList[
                                  homeWatch.configurableCategoryIndex]
                              .subCategories![j]
                              .name,
                          sId: homeWatch
                              .configureDataList[
                                  homeWatch.configurableCategoryIndex]
                              .subCategories![j]
                              .sId),
                      index: j,
                      isFromConfigureable: true,
                      onTap: () async {
                        await homeRead.productListingApi(context,
                            categoryID: homeWatch
                                .configureDataList[
                                    homeWatch.configurableCategoryIndex]
                                .subCategories![j]
                                .sId,
                            title: '',
                            type: "3",
                            isLoading: false,
                            isLoadingFromConfigurable: true);
                        await homeRead.selectedCategoryForConfigurableUpdator(
                            index: j,
                            ID: homeWatch
                                .configureDataList[
                                    homeWatch.configurableCategoryIndex]
                                .subCategories![j]
                                .sId,
                            type: '3');
                      },
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: static.width,
              child: homeWatch.productLoading &&
                      homeWatch.configurableProductList.isEmpty
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
                          homeWatch.configurableProductList.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: utils.noDataFound())
                      : Container(
                          padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                              ) +
                              EdgeInsets.only(bottom: 10.h),
                          child: Consumer<HomeController>(
                              builder: (context, homeWatch, _) {
                            return Wrap(
                              children: [
                                for (int i = 0;
                                    i <
                                        homeWatch
                                            .configurableProductList.length;
                                    i++) ...[
                                  buildImageCard(
                                    index: i,
                                    productDetailList:
                                        homeWatch.configurableProductList,
                                  ),
                                ]
                              ],
                            );
                            //
                            //   StaggeredGridView.countBuilder(
                            //   shrinkWrap: true,
                            //   staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.8),
                            //
                            //   mainAxisSpacing: 6.h,
                            //   // vertical spacing between items
                            //   crossAxisSpacing: 10.h,
                            //   // horizontal spacing between items
                            //   crossAxisCount: 2,
                            //   // no. of virtual columns in grid
                            //
                            //   scrollDirection: Axis.vertical,
                            //   itemCount: homeWatch.tabIndex==0? homeWatch.inspirationProductList.length:
                            //   homeWatch.tabIndex==1 ? homeWatch.discoverProductList.length :
                            //   homeWatch.tabIndex==2? homeWatch.tattooProductList.length:
                            //   homeWatch.fashionProductList.length,
                            //   itemBuilder: (context, index) => buildImageCard(
                            //       index: index,
                            //       productDetailList:
                            //       homeWatch.tabIndex==0? homeWatch.inspirationProductList:
                            //       homeWatch.tabIndex==1 ? homeWatch.discoverProductList :
                            //       homeWatch.tabIndex==2? homeWatch.tattooProductList:
                            //       homeWatch.fashionProductList,
                            //   ),
                            //
                            // );
                          }),
                        ),

              // Expanded(
              //   child: Consumer<HomeController>(builder: (context, homeWatch, _) {
              //     return StaggeredGridView.countBuilder(
              //       shrinkWrap: true,
              //       staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.8),
              //       // index % 3 == 0
              //       //     ? StaggeredTile.count(1, 1.6)
              //       //     : index % 3 == 1
              //       //         ? StaggeredTile.count(1, 1.1)
              //       //         : StaggeredTile.count(1, 1.4),
              //       mainAxisSpacing: 6.h,
              //       // vertical spacing between items
              //       crossAxisSpacing: 10.h,
              //       // horizontal spacing between items
              //       crossAxisCount: 2,
              //       // no. of virtual columns in grid
              //
              //       scrollDirection: Axis.vertical,
              //       itemCount: images.length,
              //       itemBuilder: (context, index) => buildImageCard(
              //         index: index,
              //       ),
              //     );
              //   }),
              // ),
            )
          ],
        ),
      ),
    );
  }

  // SelectionCategoryWidget() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         for(int i=0;i< homeWatch.configureDataList.length;i++)...[
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 10.w),
  //             width: double.infinity,
  //             height: static.width * .32,
  //             child: ListView(
  //               scrollDirection: Axis.horizontal,
  //               children: [
  //                 utils.categorySelectionContainer(
  //                     text: '${homeWatch.configureDataList[i].name}',
  //                     image: '${homeWatch.configureDataList[i].image}',
  //                     imageColor: theme.transparentColor,
  //                     isSelect: homeWatch.selectConfigurableCategory[i],
  //                     width: static.width>550? static.width*.22: static.width * .26,
  //                     height: static.width>550? static.width*.18: static.width * .26,
  //                     imageSize:  static.width * .12,
  //                     textSize: static.width>550? 8.sp:12.sp,
  //                     onTap: () {
  //                       homeRead.selectGenderStatusUpdate(index: i);
  //                     }),
  //               ],
  //             ),
  //           ),
  //
  //           // SizedBox(height: 15.h,),
  //           //
  //           // Expanded(
  //           //   child: SingleChildScrollView(
  //           //     child: Column(
  //           //       children: [
  //           //         Container(
  //           //           padding: EdgeInsets.symmetric(horizontal: 10.w),
  //           //           width: double.infinity,
  //           //           height: static.width * .35,
  //           //           child: ListView(
  //           //             scrollDirection: Axis.horizontal,
  //           //             children: [
  //           //               for(int j=0;j < homeWatch.configureDataList[i].subCategories!.length;j++)
  //           //               InspirationalContainer(
  //           //                 categories: Categories(
  //           //                     image: /*homeWatch.configureDataList[i].subCategories![j].image*/ "http://skin-canvas.arhamsoft.org/images/1695643310111.jpeg" ,
  //           //                     name:homeWatch.configureDataList[i].subCategories![j].name,
  //           //                     sId:homeWatch.configureDataList[i].subCategories![j].sId ),
  //           //                 index: j,
  //           //                 onTap: (){
  //           //                   homeRead.productListingApi(context,categoryID: homeWatch.configureDataList[i].subCategories![j].sId, title: '', type:  "3" );
  //           //                 },
  //           //               ),
  //           //
  //           //             ],
  //           //           ),
  //           //         ),
  //           //
  //           //
  //           //         Container(
  //           //           width: static.width,
  //           //           child:  Consumer<HomeController>(builder: (context, homeWatch, _){
  //           //             int lengthOfList= homeWatch.configurableProductList.length;
  //           //             return homeWatch.productLoading && homeWatch.configurableProductList.isEmpty?
  //           //             Container(
  //           //               width: static.width,
  //           //               padding: EdgeInsets.symmetric(
  //           //                 horizontal: 4.w,
  //           //               ),
  //           //               child: Wrap(
  //           //                 alignment: WrapAlignment.spaceBetween,
  //           //                 children: [
  //           //                   for (int i = 0; i < 4; i++) utils.productShimmer(),
  //           //                 ],
  //           //               ),
  //           //             ) :  !homeWatch.productLoading &&  homeWatch.configurableProductList.isEmpty?
  //           //             Container(
  //           //                 alignment: Alignment.center,
  //           //                 child:   utils.noDataFound()
  //           //             ):
  //           //
  //           //             Container(
  //           //               padding: EdgeInsets.symmetric(horizontal: 0.w,) + EdgeInsets.only(bottom: 10.h),
  //           //               child: Consumer<HomeController>(builder: (context, homeWatch, _) {
  //           //                 return Wrap(
  //           //                   children: [
  //           //                     for(int i =0; i < lengthOfList ;i++)...[
  //           //                       buildImageCard(
  //           //                         index: i,
  //           //                         productDetailList: homeWatch.configurableProductList,
  //           //                       ),
  //           //                     ]
  //           //                   ],
  //           //                 );
  //           //                 //
  //           //                 //   StaggeredGridView.countBuilder(
  //           //                 //   shrinkWrap: true,
  //           //                 //   staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.8),
  //           //                 //
  //           //                 //   mainAxisSpacing: 6.h,
  //           //                 //   // vertical spacing between items
  //           //                 //   crossAxisSpacing: 10.h,
  //           //                 //   // horizontal spacing between items
  //           //                 //   crossAxisCount: 2,
  //           //                 //   // no. of virtual columns in grid
  //           //                 //
  //           //                 //   scrollDirection: Axis.vertical,
  //           //                 //   itemCount: homeWatch.tabIndex==0? homeWatch.inspirationProductList.length:
  //           //                 //   homeWatch.tabIndex==1 ? homeWatch.discoverProductList.length :
  //           //                 //   homeWatch.tabIndex==2? homeWatch.tattooProductList.length:
  //           //                 //   homeWatch.fashionProductList.length,
  //           //                 //   itemBuilder: (context, index) => buildImageCard(
  //           //                 //       index: index,
  //           //                 //       productDetailList:
  //           //                 //       homeWatch.tabIndex==0? homeWatch.inspirationProductList:
  //           //                 //       homeWatch.tabIndex==1 ? homeWatch.discoverProductList :
  //           //                 //       homeWatch.tabIndex==2? homeWatch.tattooProductList:
  //           //                 //       homeWatch.fashionProductList,
  //           //                 //   ),
  //           //                 //
  //           //                 // );
  //           //               }),
  //           //             );
  //           //           }
  //           //           ),
  //           //
  //           //
  //           //           // Expanded(
  //           //           //   child: Consumer<HomeController>(builder: (context, homeWatch, _) {
  //           //           //     return StaggeredGridView.countBuilder(
  //           //           //       shrinkWrap: true,
  //           //           //       staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.8),
  //           //           //       // index % 3 == 0
  //           //           //       //     ? StaggeredTile.count(1, 1.6)
  //           //           //       //     : index % 3 == 1
  //           //           //       //         ? StaggeredTile.count(1, 1.1)
  //           //           //       //         : StaggeredTile.count(1, 1.4),
  //           //           //       mainAxisSpacing: 6.h,
  //           //           //       // vertical spacing between items
  //           //           //       crossAxisSpacing: 10.h,
  //           //           //       // horizontal spacing between items
  //           //           //       crossAxisCount: 2,
  //           //           //       // no. of virtual columns in grid
  //           //           //
  //           //           //       scrollDirection: Axis.vertical,
  //           //           //       itemCount: images.length,
  //           //           //       itemBuilder: (context, index) => buildImageCard(
  //           //           //         index: index,
  //           //           //       ),
  //           //           //     );
  //           //           //   }),
  //           //           // ),
  //           //
  //           //
  //           //         )
  //           //
  //           //       ],
  //           //     ),
  //           //   ),
  //           // ),
  //
  //         ]
  //
  //       ],
  //     ),
  //   );
  // }

  Widget buildImageCard({index, List<Products>? productDetailList}) {
    return GestureDetector(
      onTap: () {
        homeWatch.categoryStatusUpdate(index: index);
        homeWatch.selectedProductUpdate(value: productDetailList[index]);
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: homeWatch.categoryStatus[index]
                          ? theme.orangeColor
                          : theme.whiteColor,
                    ),
                    color: theme.backGroundColor),
                child: Stack(
                  children: [
                    FractionallySizedBox(
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
                    if (homeWatch.categoryStatus[index]) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: theme.blackColor.withOpacity(.5),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Column(
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //
                      //           // print( homeWatch.productList[index].sId.toString());
                      //           wishListRead.makeAndRemoveWishListApi(context,productID: homeWatch.productList[index].sId.toString(),status: !homeWatch.productList[index].isFeatured!);
                      //         },
                      //         child: Container(
                      //           margin: EdgeInsets.only(
                      //             left: 6.w,
                      //             right: 6.w,
                      //             top: 6.h,
                      //           ),
                      //           height:  static.width>550? 26.w:30.w,
                      //           width: static.width>550? 28.w:32.w,
                      //           decoration: BoxDecoration(
                      //             color: theme.orangeColor,
                      //             borderRadius: BorderRadius.circular(6.r),
                      //           ),
                      //           child: Center(
                      //             child: Icon(
                      //               size: static.width>550? 20.sp: 25.sp,
                      //               homeWatch.productList[index].isFeatured!
                      //                   ? CupertinoIcons.heart_fill
                      //                   : CupertinoIcons.heart,
                      //               color: theme.whiteColor,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           Navigator.pushNamed(context, route.myCartScreenRoute);
                      //         },
                      //         child: Container(
                      //             margin: EdgeInsets.symmetric(
                      //                 horizontal: 5.w, vertical: 8.h),
                      //             child: Image.asset(
                      //               'assets/Icons/cart.png',
                      //               height:  static.width>550? 30.w:35.w,
                      //               width: static.width>550? 30.w:35.w,
                      //             )),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            homeRead.getColorFromSizeApi(context,
                                loadingMessage: "Loading",
                                isRoute: true,
                                size: homeWatch.selectedProduct!.attributes![1]
                                    .size![0].value
                                    .toString());

                            //Navigator.pushNamed(context, route.productDetailScreenRoute);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 6.w,
                            ),
                            height: 30.h,
                            width: static.width > 500
                                ? static.width * .24
                                : static.width * .32,
                            decoration: BoxDecoration(
                              color: theme.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Image.asset(
                                      'assets/Images/arrow-up.png',
                                      height: static.width > 550 ? 8.h : 12.h,
                                      width: static.width > 550 ? 8.w : 12.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Check Detail',
                                      style: utils.generalHeading(
                                        theme.blackColor,
                                        size: static.width > 550 ? 8.sp : 12.sp,
                                        fontFamily: 'finalBold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
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
                  Text(
                    '${productDetailList![index].title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: utils.labelStyleB(theme.whiteColor.withOpacity(.8)),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${priceKey}${productDetailList[index].price}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: utils.labelStyle(theme.orangeColor.withOpacity(.8),
                        fontFamily: 'finalBold'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildImageCard({index}) {
  //   return GestureDetector(
  //     onTap: () {
  //       homeWatch.categoryStatusUpdate(index: index);
  //       print('Button Hit${homeWatch.categoryStatus[index]}');
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8.r),
  //         color: theme.transparentColor,
  //       ),
  //       margin: EdgeInsets.only(bottom: 30.h),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8.r),
  //                   border: Border.all(
  //                     color: homeWatch!.categoryStatus[index]
  //                         ? theme.orangeColor
  //                         : theme.transparentColor,
  //                   ),
  //                   color: theme.backGroundColor
  //                   // gradient: LinearGradient(
  //                   //   colors: gradientColors,
  //                   //   // Replace with your desired colors
  //                   //   begin: Alignment.topCenter,
  //                   //   end: Alignment.bottomCenter,
  //                   // ),
  //                   ),
  //               child: Stack(
  //                 children: [
  //                   FractionallySizedBox(
  //                     widthFactor: 1.0,
  //                     heightFactor: 1.0,
  //                     child: ClipRRect(
  //                       // Wrap the image with ClipRRect
  //                       borderRadius: BorderRadius.circular(8.r),
  //                       child: Image.asset(
  //                         // 'https://source.unsplash.com/random?sig=$index',
  //                         images[index],
  //                         fit: BoxFit.contain,
  //                       ),
  //                     ),
  //                   ),
  //                   if (homeWatch.categoryStatus[index]) ...[
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(8.r),
  //                         color: theme.blackColor.withOpacity(.5),
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topRight,
  //                       child: Column(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {
  //                            //   homeRead.favouriteProductUpdator(index: index);
  //
  //
  //                             },
  //                             child: Container(
  //                               margin: EdgeInsets.only(
  //                                 left: 6.w,
  //                                 right: 6.w,
  //                                 top: 6.h,
  //                               ),
  //                               height: 30.w,
  //                               width: 32.w,
  //                               decoration: BoxDecoration(
  //                                 color: theme.orangeColor,
  //                                 borderRadius: BorderRadius.circular(6.r),
  //                               ),
  //                               child: Center(
  //                                 child: Icon(
  //                                   size: 25.sp,
  //                                   homeWatch.isFavouriteProduct[index]
  //                                       ? CupertinoIcons.heart_fill
  //                                       : CupertinoIcons.heart,
  //                                   color: theme.whiteColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.pushNamed(
  //                                   context, route.myCartScreenRoute);
  //                             },
  //                             child: Container(
  //                                 margin: EdgeInsets.symmetric(
  //                                     horizontal: 5.w, vertical: 8.h),
  //                                 child: Image.asset(
  //                                   'assets/Icons/cart.png',
  //                                   height: 35.w,
  //                                   width: 35.w,
  //                                 )),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.bottomCenter,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           Navigator.pushNamed(
  //                               context, route.productDetailScreenRoute);
  //                         },
  //                         child: Container(
  //                           margin: EdgeInsets.symmetric(
  //                             vertical: 10.h,
  //                             horizontal: 6.w,
  //                           ),
  //                           height: 30.h,
  //                           width: static.width * .32,
  //                           decoration: BoxDecoration(
  //                             color: theme.whiteColor,
  //                             borderRadius: BorderRadius.circular(20.r),
  //                           ),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(4.0),
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceAround,
  //                               children: [
  //                                 Image.asset(
  //                                   'assets/Images/arrow-up.png',
  //                                   height: 12.h,
  //                                   width: 12.w,
  //                                   fit: BoxFit.contain,
  //                                 ),
  //                                 Text(
  //                                   'Check Detail',
  //                                   style: utils.generalHeading(
  //                                     theme.blackColor,
  //                                     size: 13.sp,
  //                                     fontFamily: 'finalBold',
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ]
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 8.h,
  //           ),
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style:
  //                       utils.smallLabelStyle(theme.whiteColor.withOpacity(.8)),
  //                 ),
  //                 SizedBox(height: 2.h),
  //                 Text(
  //                   'USD. 6.00',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: utils.smallLabelStyle(
  //                       theme.orangeColor.withOpacity(.8),
  //                       fontFamily: 'finalBold'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget createProductButton() {
    return homeWatch.categoryStatus.contains(true)
        ? Container(
            width: static.width,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: utils.button(
              textSize: static.width > 550 ? 10.sp : 20.sp,
              text: 'Next',
              buttonColor: theme.orangeColor,
              borderColor: theme.orangeColor,
              fontFamily: 'finalBold',
              ontap: () {
                // homeRead.selectedProductColorImageIndexUpdate(index: 0);

                homeRead.getColorFromSizeApi(context,
                    loadingMessage: "Loading",
                    isRoute: true,
                    size: homeWatch
                        .selectedProduct!.attributes![1].size![0].value);
              },
              textColor: theme.whiteColor,
              width: static.width,
            ),
          )
        : Container();
  }
}

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
import 'package:skincanvas/AppUtils/Widgets/WidgetUpAnimation.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/main.dart';

class CreateProductHelper {
  BuildContext context;

  CreateProductHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var orderWatch = navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead = navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();

  Widget topBar() {
    return utils.appBar(
      context,
      barText: '${homeWatch.selectedProduct!.title.toString()}',
      onPress: () {
        homeRead.updateIsShowGraphicsContainer(isBackButton: true);
        homeRead.categoryStatusUpdate(
            index: homeWatch.selectedcategorystatusindex);
        Navigator.pop(context);
      },
    );
  }

  Widget showProduct() {
    return Container(
      height: static.height * .45,
      width: static.width,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: theme.lightBlackColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.h,
            left: 0.w,
            right: 0.w,
            child: Transform.scale(
              scale: 0.8,
              child: CachedNetworkImage(
                height: static.height * .5,
                imageUrl: homeWatch
                    .mdColorFromSizeModal
                    .colorFromSizeDataList![
                        homeWatch.selectedProductColorImageIndex]
                    .image
                    .toString(),
                /*homeWatch.selectedProduct!.attributes!.first.color!.isNotEmpty
                      ? homeWatch.selectedProduct!.attributes!.first.color![homeWatch.selectedProductColorImageIndex].value == '' ||
                              homeWatch.selectedProduct!.attributes!.first.color![homeWatch.selectedProductColorImageIndex].value == null
                          ? '${homeWatch.selectedProduct!.image}'
                          : homeWatch.selectedProduct!.attributes!.first.color![homeWatch.selectedProductColorImageIndex].image.toString()
                      : '${homeWatch.selectedProduct!.image}',*/
                alignment: Alignment.center,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    utils.loadingShimmer(
                  height: static.width * .5.w,
                  width: static.width * .5.w,
                ),
                errorWidget: (context, url, error) => utils.loadingShimmer(
                  height: static.width * .5.w,
                  width: static.width * .5.w,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Size',
                      style: utils.xHeadingStyleB(theme.whiteColor),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0;
                                i <
                                    homeWatch.selectedProduct!.attributes![1]
                                        .size!.length;
                                i++)
                              sizeBox(
                                  name:
                                      '${homeWatch.selectedProduct!.attributes![1].size![i].value}',
                                  status: homeWatch.sizesActivationList[i],
                                  onTap: () async {
                                    await homeRead.sizeChangeLoadingUpdate(
                                        value: false);
                                    await homeRead.getColorFromSizeApi(context,
                                        loadingMessage: "Changing Size",
                                        isRoute: false,
                                        size: homeWatch.selectedProduct!
                                            .attributes![1].size![i].value);

                                    if (homeWatch.sizeChangeLoading)
                                      homeRead.sizesActivationListUpdate(
                                          index: i);
                                  }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Color',
                      style: utils.xHeadingStyleB(theme.whiteColor),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      alignment: WrapAlignment.end,
                      children: [
                        for (int i = 0;
                            i <
                                homeWatch.mdColorFromSizeModal
                                    .colorFromSizeDataList!.length;
                            i++)
                          homeWatch.mdColorFromSizeModal
                                          .colorFromSizeDataList![i].color ==
                                      '' ||
                                  homeWatch.mdColorFromSizeModal
                                          .colorFromSizeDataList![i].color ==
                                      null
                              ? SizedBox()
                              : colorBox(
                                  color: utils.hexToColor(homeWatch
                                      .mdColorFromSizeModal
                                      .colorFromSizeDataList![i]
                                      .color
                                      .toString()),
                                  index: i,
                                  onTap: () {
                                    homeRead
                                        .selectedProductColorImageIndexUpdate(
                                            index: i);
                                  },
                                ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), ///////Working
    );
  }

  Widget sizeBox({name, status = false, onTap}) {
    return status
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.orangeColor,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Text(
                  name,
                  style: utils.labelStyleB(theme.whiteColor),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                name,
                style: utils.headingStyleB(theme.whiteColor),
              ),
            ),
          );
  }

  Widget colorBox({color, index, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '-',
            style: utils.generalHeading(
                index == homeWatch.selectedProductColorImageIndex
                    ? theme.orangeColor
                    : theme.midLightGreyColor,
                size: static.width > 550 ? 20.sp : 30.sp),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            width: static.width > 550 ? 8.w : 12.w,
            height: static.width > 550 ? 8.w : 12.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget textFields() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Align(
        alignment: Alignment.center,
        child: homeWatch.isShowGraphicsContainer
            ? selectGraphic()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 22.w, right: 25.w),
                    child: utils.inputField(
                      textColor: theme.lightGreyColor,
                      placeholderColor: theme.midGreyColor,
                      placeholder: 'Graphic prompt',
                      isSecure: false,
                      controller: homeWatch.productDesirePromptController,
                      maxLines: 1,
                      textfieldColor: theme.lightBlackColor,
                      borderColor: theme.lightBlackColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 22.w, right: 25.w),
                    child: utils.inputField(
                      textColor: theme.blackColor,
                      placeholderColor: theme.midGreyColor,
                      placeholder: 'Desire Text',
                      isSecure: false,
                      controller: homeWatch.productDesireTextController,
                      maxLines: 1,
                      textfieldColor: theme.whiteColor,
                      borderColor: theme.lightBlackColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget selectGraphic() {
    return WidgetUpAnimation(
      top_to_bottom: false,
      height: 100.0,
      // The distance the widget will move during animation
      duration: Duration(milliseconds: 700),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Your Graphic',
                      style: utils.xHeadingStyle(theme.whiteColor,
                          fontFamily: 'finalBold'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeRead.updateIsShowGraphicsContainer(isBackButton: true);
                      homeWatch.productDesirePromptController.clear();
                      homeWatch.productDesireTextController.clear();
                    },
                    icon: Icon(
                      Icons.close,
                      color: theme.whiteColor,
                      size: 20.w,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0;
                      i <
                          homeWatch.mdTattooAndGraphicsGenerationModal
                              .imagesList!.length;
                      i++)
                    graphicContainer(
                      image:
                          '${homeWatch.mdTattooAndGraphicsGenerationModal.imagesList![i].url}',
                      isSelect: homeWatch.selectGraphics[i],
                      onTap: () {
                        homeRead.selectGraphicsStatusUpdate(index: i);
                      },
                    ),
                  // graphicContainer(
                  //   image: 'assets/Images/demoGraphics1.png',
                  //   isSelect: orderWatch.selectGraphics[0],
                  //   onTap: () {
                  //     orderRead.selectGraphicsStatusUpdate(index: 0);
                  //   },
                  // ),
                  // graphicContainer(
                  //   image: 'assets/Images/demoGraphics.png',
                  //   isSelect: orderWatch.selectGraphics[1],
                  //   onTap: () {
                  //     orderRead.selectGraphicsStatusUpdate(index: 1);
                  //   },
                  // ),
                  // graphicContainer(
                  //   image: 'assets/Images/demoGraphics2.png',
                  //   isSelect: orderWatch.selectGraphics[2],
                  //   onTap: () {
                  //     orderRead.selectGraphicsStatusUpdate(index: 2);
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget graphicContainer({image, onTap, isSelect}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        width: static.width > 550 ? static.width * .22 : static.width * .26,
        height: static.width > 550 ? static.width * .22 : static.width * .26,
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: CachedNetworkImage(
            width: isSelect ? static.width > 500 ? static.width * .20 : static.width * .24 : static.width > 500 ? static.width * .18 : static.width * .22,
            imageUrl: '$image',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                utils.loadingShimmer(
              height:
                  static.width > 550 ? static.width * .15 : static.width * .2.w,
              width:
                  static.width > 550 ? static.width * .15 : static.width * .2.w,
            ),
            errorWidget: (context, url, error) => utils.loadingShimmer(
              height: static.width > 550
                  ? static.width * .15
                  : static.width * .18.w,
              width: static.width > 550
                  ? static.width * .15
                  : static.width * .18.w,
            ),
            fit: BoxFit.contain,
          ),

          // Image.asset(
          //   '$image',
          //   width: isSelect ? static.width * .22 : static.width * .19,
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  Widget nextButton() {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      child: utils.button(
        textSize: static.width > 550 ? 10.sp : 20.sp,
        text: homeWatch.isShowGraphicsContainer
            ? homeWatch.selectGraphics.contains(true)
                ? 'Awesome! Check Results'
                : 'Regenerate'
            : 'Next',
        buttonColor: theme.orangeColor,
        borderColor: theme.orangeColor,
        fontFamily: 'finalBold',
        ontap: () async {
          if (homeWatch.productDesirePromptController.text.isEmpty) {
            utils.showToast(context,
                message: 'Please add your graphic prompt field');
          } else {
            if (homeRead.selectGraphics.contains(true)) {

              await homeRead.sizeGroupAPi(context, isLoading: true, isFromProduct: true);
              if (homeWatch.productDesireTextController.text.isNotEmpty)
                await homeRead.sizeGroupAPi(context, isLoading: true, isDesireText: true);

              await homeRead.selectableTattoosAndGraphicListUpdate();

              homeRead.updateImageCurrentColor(color: Colors.transparent);
              homeRead.updateColor(Colors.transparent);
              homeRead.updateSelectedFontFamilyIndex(index: 0);
              await homeRead.isImageOrTextUpdation(value: true);
              homeRead.routingForEditScreenFromTattoo(value: false);
              homeRead.updateIsFromTattoo(value: false);
              await homeRead.updateBaseColorIniatlize(
                  Color(0xffffffff));

              Navigator.pushNamed(
                  context, route.editTattooAndProductScreenRoute);
            } else {
              homeRead.tattooAndGraphicGenerationAPi(context,
                  color: "Mixed Colors", isFromProduct: true);
            }

            // homeRead.selectGraphicsStatusInitialize(imagesLength: 3);
          }
        },
        textColor: theme.whiteColor,
        width: static.width,
      ),
    );
  }
}

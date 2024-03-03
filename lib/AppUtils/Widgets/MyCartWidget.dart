import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Models/MDCartModal.dart';
import 'package:skincanvas/Models/MDProductGraphicAndText.dart';

class MyCartWidget extends StatefulWidget {
  String productName;
  String productPrice;
  String productAttribute;
  String productImage;
  int quantity;
  List<Designs> productGraphicAndTextList;
  Function() onTap;
  Function() decrementOnTap;
  Function() incrementOnTap;
  bool status = false;
  bool isFromProductScreen = false;

  MyCartWidget({
    required this.productName,
    required this.productPrice,
    required this.productAttribute,
    required this.productImage,
    required this.quantity,
    required this.productGraphicAndTextList,
    required this.onTap,
    required this.decrementOnTap,
    required this.incrementOnTap,
    required this.status,
    required this.isFromProductScreen,
  });

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  Color? orderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: widget.status
                    ? Container(
                        margin: EdgeInsets.only(
                            top: static.width * .08, right: 10.w),
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.orangeColor,
                        ),
                        child: Icon(
                          CupertinoIcons.checkmark_alt,
                          size: 12.sp,
                          color: theme.whiteColor,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(
                            top: static.width * .08, right: 10.w),
                        alignment: Alignment.center,
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.transparentColor,
                            border: Border.all(color: theme.lightGreyColor)),
                      ),
              ),
              Container(
                width: static.width * .18,
                height: static.width * .18,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: widget.productGraphicAndTextList.isNotEmpty ||
                            widget.productGraphicAndTextList.length >= 1
                        ? theme.blackColor
                        : theme.lightGreyColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: CachedNetworkImage(
                  imageUrl: '${widget.productImage}',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      utils.loadingShimmer(
                    width: static.width * .14,
                    height: static.width * .14,
                  ),
                  errorWidget: (context, url, error) => utils.loadingShimmer(
                    width: static.width * .14,
                    height: static.width * .14,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: utils.xHeadingStyle(
                        theme.whiteColor,
                        fontFamily: 'finalBold',
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      widget.productAttribute,
                      style: utils.smallLabelStyle(
                        theme.midGreyColor,
                        fontFamily: 'finalBook',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    widget.isFromProductScreen
                        ? Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < widget.productGraphicAndTextList.length;
                                  i++)
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3.h),
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        width: 30.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: theme.lightGreyColor,
                                          border: Border.all(
                                              color: theme.orangeColor),
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${widget.productGraphicAndTextList[i].image}',
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              utils.loadingShimmer(
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              utils.loadingShimmer(
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.productGraphicAndTextList[i]
                                              .prompt!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: utils.smallLabelStyle(
                                              theme.midGreyColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " ${widget.productPrice}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: utils.smallLabelStyle(theme.orangeColor,
                              fontFamily: 'finalBold'),
                        ),
                        Expanded(child: SizedBox()),
                        quantityScale(
                          quantity: widget.quantity,
                          decrementOnTap: widget.decrementOnTap,
                          incrementOnTap: widget.incrementOnTap,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Divider(
            color: theme.midGreyColor.withOpacity(.6),
            thickness: 0.3,
          ),
        ],
      ),
    );
  }

  quantityScale({quantity, decrementOnTap, incrementOnTap}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          InkWell(
            onTap: decrementOnTap,
            child: Icon(
              CupertinoIcons.minus,
              color: theme.lightGreyColor,
              size: 16.sp,
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 2.h),
            margin: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              color: theme.lightBlackColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(quantity.toString(),
                style: utils.labelStyle(theme.whiteColor)),
          ),
          SizedBox(
            width: 6.w,
          ),
          InkWell(
            onTap: incrementOnTap,
            child: Icon(
              Icons.add,
              color: theme.lightGreyColor,
              size: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';

class MyWishListWidget extends StatefulWidget {
  String productName;
  String productPrice;
  String productAttribute;
  String productImage;
  Function()? onTap;

  MyWishListWidget({
    required this.productName,
    required this.productPrice,
    required this.productAttribute,
    required this.productImage,
    this.onTap
  });

  @override
  State<MyWishListWidget> createState() => _MyWishListWidgetState();
}

class _MyWishListWidgetState extends State<MyWishListWidget> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  Color? orderColor;

  bool status = false;

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

              Container(
                width: static.width * .18,
                height: static.width * .18,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: theme.lightGreyColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: CachedNetworkImage(
                  imageUrl: widget.productImage!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      utils.loadingShimmer(
                        width: static.width * .12,
                        height: static.width * .12,
                      ),
                  errorWidget: (context, url, error) => utils.loadingShimmer(
                    width: static.width * .12,
                    height: static.width * .12,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      widget.productPrice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: utils.smallLabelStyle(theme.orangeColor,
                          fontFamily: 'finalBold'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 25.w,
              ),

              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  child: Icon(Icons.favorite,size: 28.sp,color: theme.orangeColor,),
                ),
              )
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

}

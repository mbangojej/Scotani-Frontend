import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Models/MDHomeCategoryModal.dart';
import 'package:skincanvas/main.dart';

import '../AppUtils.dart';

class InspirationalContainer extends StatefulWidget {
  Categories? categories;
  int index;
  Function()? onTap;
  bool isFromConfigureable;

  InspirationalContainer(
      {this.categories,
      required this.index,
      this.onTap,
      this.isFromConfigureable = false});

  @override
  State<InspirationalContainer> createState() => _InspirationalContainerState();
}

class _InspirationalContainerState extends State<InspirationalContainer> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("The image is:" + widget.categories!.image.toString());
    print("The name is:" + widget.categories!.name.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width:
                  static.width > 550 ? static.width * .16 : static.width * .20,
              height:
                  static.width > 550 ? static.width * .18 : static.width * .20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: theme.whiteColor),
              child: CachedNetworkImage(
                imageUrl: widget.categories!.image.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    utils.loadingShimmer(
                  height: static.width > 550
                      ? static.width * .15
                      : static.width * .2.w,
                  width: static.width > 550
                      ? static.width * .15
                      : static.width * .2.w,
                ),
                errorWidget: (context, url, error) => utils.loadingShimmer(
                  height: static.width > 550
                      ? static.width * .15
                      : static.width * .2.w,
                  width: static.width > 550
                      ? static.width * .15
                      : static.width * .2.w,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '${widget.categories!.name}',
              style: utils.smallLabelStyle(
                (widget.isFromConfigureable
                        ? homeWatch.selectedConfigurableCategoryIndex ==
                            widget.index
                        : homeWatch.selectedCategoryIndex == widget.index)
                    ? theme.orangeColor
                    : theme.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

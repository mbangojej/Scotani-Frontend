import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';

class NotificationsWidget extends StatefulWidget {
  String NotificationTitle;
  String NotificationTime;
  String NotificationStatus;
  Function() onTap;

  NotificationsWidget({
    required this.NotificationTitle,
    required this.NotificationTime,
    required this.NotificationStatus,
     required this.onTap,
  });

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  Color? notificationColor;

  @override
  Widget build(BuildContext context) {
    if (widget.NotificationStatus == 'true') {
      notificationColor = theme.greenColor;
    } else {
      notificationColor = theme.redColor;
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: notificationColor == theme.redColor
                ? theme.lightBlackColor
                : null,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  height: 10.w,
                  width: 10.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: notificationColor),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          widget.NotificationTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: utils.headingStyle(
                            theme.whiteColor.withOpacity(.7),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        widget.NotificationTime,
                        style: utils.smallLabelStyle(
                          theme.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: static.width,
            height: .15.h,
            color: notificationColor == theme.redColor
                ? theme.whiteColor.withOpacity(.6)
                : theme.midGreyColor.withOpacity(.6),
          )
          // Divider(
          //   color:  notificationColor == theme.redColor?theme.transparentColor: theme.midGreyColor.withOpacity(.6),
          //   thickness: 0.3,
          // ),
        ],
      ),
    );
  }
}

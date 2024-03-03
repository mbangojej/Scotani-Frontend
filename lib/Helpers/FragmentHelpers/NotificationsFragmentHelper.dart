import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/NotificationsWidget.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/main.dart';

class NotificationsFragmentHelper {
  BuildContext context;
  ScrollController scrollController;

  NotificationsFragmentHelper(this.context, this.scrollController) {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        if (generalWatch.mdNotificationListModal.data!.pagination!.pages!
                .toInt() >=
            generalWatch.notificationPage) {
          await generalRead.getNotificationListApi(context,
              isLoading: true, page: generalWatch.notificationPage);
        }
        print('scroll');
      }
    });
  }

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget notificationText() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(top: 40.h),
      width: static.width,
      child: Container(
        width: static.width * .6,
        child: Text(
          'Notifications',
          style: utils.generalHeadingBold(theme.whiteColor,
              size: static.width > 550 ? 20.sp : 26.sp,
              fontFamily: 'finalBold'),
        ),
      ),
    );
  }

  Widget notificationsHistory() {
    return Consumer<GeneralController>(builder: (context, generalWatch, _) {
      return generalWatch.isLoadingNotification
          ? Container(alignment: Alignment.center, child: utils.noDataFound(text: 'No Notifications Found'))
          : SingleChildScrollView(
              controller: scrollController,
              child: Consumer<GeneralController>(
                  builder: (context, generalWatch, _) {
                return Padding(
                    padding: EdgeInsets.only(bottom: 40.h, top: 20.h),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        for (int i = 0;
                            i < generalWatch.notificationList.length;
                            i++)
                          NotificationsWidget(
                            NotificationTitle:
                                '${generalWatch.notificationList[i].description}',
                            NotificationTime:
                                '${generalWatch.notificationList[i].title}',
                            NotificationStatus:
                                '${generalWatch.notificationList[i].status}',
                            onTap: () async{
                              if (generalWatch.notificationList[i].status ==
                                  false) {
                               await generalWatch.changeNotificationStatusApi(
                                    context,
                                    id: generalWatch.notificationList[i].sId);
                              }
                              utils.notificationDetailDialogBox(
                                context,
                                orderStatus:
                                    '${generalWatch.notificationList[i].title}',
                                text:
                                    '${generalWatch.notificationList[i].description}',
                              );
                            },
                          ),
                      ],
                    ));
              }),
            );
    });
  }
}

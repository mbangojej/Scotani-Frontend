import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/Models/design_apparel_user.dart';

class CustomImages extends StatelessWidget {
  final DesignApparelUsers designApparelUsers;

  CustomImages({required this.designApparelUsers});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 143.h,
      width: 103.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: AssetImage(
              "${designApparelUsers.imgUrl}",
            ),
            fit: BoxFit.cover,
          )),
    );
  }
}

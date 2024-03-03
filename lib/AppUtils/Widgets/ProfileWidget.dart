import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';


class ProfileDetailContainer extends StatefulWidget {
  @override
  State<ProfileDetailContainer> createState() => _ProfileDetailContainerState();
}

class _ProfileDetailContainerState extends State<ProfileDetailContainer> {
  var utils = AppUtils();
  var static =Statics();
  var theme =ThemeColors();


  @override
  Widget build(BuildContext context) {
    var generalWatch = context.watch<GeneralController>();
    return Container(
      width: static.width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.w),
      decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: Customshape(),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:theme.orangeColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: Container(
                        height: 100.h,
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w) ,
                        color: theme.transparentColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: static.width>550? 45.w:55.w,
                      child: ClipOval(
                        child:CachedNetworkImage(
                          imageUrl: '${generalWatch.profilePhotoValue}',
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              utils.loadingShimmer(
                                width: 100.w,
                                height: 100.h,
                              ),
                          errorWidget: (context, url, error) => utils.loadingShimmer(
                            width: 100.w,
                            height: 100.h,
                          ),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                generalWatch.fullNameValue!,
                style: utils.xlHeadingStyleB(theme.blackColor),
              ),
              SizedBox(
                height: 20.h,
              ),


              utils.profileDataConatiner(label: 'Email',desription: '${generalWatch.emailValue}',icon: Icons.email),
              utils.profileDataConatiner(label: 'Phone',desription: '${generalWatch.phoneValue}',icon: Icons.phone),
              utils.profileDataConatiner(label: 'Address',desription: '${generalWatch.addressValue}',icon: Icons.location_pin),


              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.clear_circled,color: theme.orangeColor,size: static.width>550? 30.w :40.w,
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            width: static.width - 60,
            child: ClipPath(
              clipper: CustomshapeBottom(),
              child: Container(
                height: 50.h,
                width: static.width,
                decoration: BoxDecoration(
                  color: theme.orangeColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(width/2, height-50, width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}

class CustomshapeBottom extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height);
    path.quadraticBezierTo(width/2, height+30, width, 0);
    path.lineTo(width, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
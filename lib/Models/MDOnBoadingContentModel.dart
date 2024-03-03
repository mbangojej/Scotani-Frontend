class OnBoardingContents {
  final String image;
  final String desc;

  OnBoardingContents({
    required this.image,
    required this.desc,
  });
}

List<OnBoardingContents> onBoardingContentsList = [
  OnBoardingContents(
    image: "assets/Images/onBoard1.png",
    desc:
        "Simply have fun experimenting with different looks, our app has got you covered!",
  ),
  OnBoardingContents(
    image: "assets/Images/onBoard2.png",
    desc:
        "Unleash your creativity and style with our innovative temporary tattoo app.",
  ),
  OnBoardingContents(
    image: "assets/Images/onBoard3.png",
    desc:
        "Whether you want to try out a bold design, show off your unique personality",
  ),
];






class MDonBoardingModal {
  int? status;
  String? message;
  List<SplashData>? splashData;

  MDonBoardingModal({this.status, this.message, this.splashData});

  MDonBoardingModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['splashData'] != null) {
      splashData = <SplashData>[];
      json['splashData'].forEach((v) {
        splashData!.add(new SplashData.fromJson(v));
      });
    }
  }
}

class SplashData {
  String? text;
  String? image;

  SplashData({this.text, this.image});

  SplashData.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
  }
}

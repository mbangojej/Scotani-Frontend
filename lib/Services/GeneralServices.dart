// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class GeneralApisServices {
  Dio dio = Dio();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  getCMS({data}) async {
    var url = static.baseURL + static.settingURL + static.getCMS;
    print(url.toString());

    try {
      Response response = await dio.get(url,
          data: data,
          options: Options(
            headers: {
              'user-identity': '${generalWatch.userIDValue}',
              'access-token': '${generalWatch.userTokenValue}',
              'X-auth-token': '${static.xAuthToken}',
            },
          ));

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  editProfile({data}) async {
    var url = static.baseURL + static.userURL + static.editProfile;
    print(url.toString());

    try {
      Response response = await dio.put(url,
          data: data,
          options: Options(
            headers: {
              'user-identity': '${generalWatch.userIDValue}',
              'access-token': '${generalWatch.userTokenValue}',
              'X-auth-token': '${static.xAuthToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  faq({data}) async {
    var url = static.baseURL + static.faq + static.list;
    print(url.toString());

    try {
      Response response = await dio.get(url,
          data: data,
          options: Options(
            headers: {
              'X-auth-token': '${static.xAuthToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  uploadingImage(data) async {
    var url = static.baseURL + static.authURL + static.uploadImage;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              'X-auth-token': '${static.xAuthToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  onBoard() async {
    var url = static.baseURL + static.authURL + static.onBoardingScreen;
    print(url.toString());

    try {
      Response response = await dio.get(url,
          options: Options(
            headers: {
              'X-auth-token': '${static.xAuthToken}',
              'Authorization': 'Bearer ${static.bearerToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  notificationListing(data) async {
    var url = static.baseURL + static.notificationsURL + static.list;
    print(url.toString());

    Response response = await dio.get(url,
        data: data,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ));
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  notificationStatus() async {
    var url = static.baseURL + static.notificationsURL + static.changeStatus;
    print(url.toString());

    Response response = await dio.post(url,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ));
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  changeNotificationStatus(data) async {
    var url = static.baseURL +
        static.notificationsURL +
        static.changeNotificationStatus;
    print(url.toString());

    Response response = await dio.post(url,
        data: data,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ));
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  errorAndReport({data}) async {
    var url = static.baseURL + static.authURL + static.reportIssueBug;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              'user-identity': '${generalWatch.userIDValue}',
              'access-token': '${generalWatch.userTokenValue}',
              'X-auth-token': '${static.xAuthToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  edgesCutting({data}) async {
    var url = static.edgesCuttingURL;
    print(url.toString());

    try {
      Response response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  backGroundRemover({data}) async {
    var url = static.removeBackGroundURL;
    print(url.toString());

    try {
      Response response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  pythonBackGroundRemover({data}) async {
    var url = static.pythonBackGroundURL;
    print(url.toString());

    try {
      Response response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  getSetting() async {
    var url = static.baseURL + static.authURL + static.getSettings;
    print(url.toString());

    try {
      Response response = await dio.get(url,
          options: Options(
            headers: {
              'X-auth-token': '${static.xAuthToken}',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  getProfile() async {
    var url = static.baseURL + static.userURL + static.getProfile;
    print(url.toString());

    Response response = await dio.get(url,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ));
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}

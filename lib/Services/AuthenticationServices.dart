import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class AuthenticationApisServices {
  Dio dio = Dio();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  signup({
    data,
  }) async {
    var url = static.baseURL + static.authURL + static.signup;
    print(url.toString());

    // FormData formData = FormData.fromMap({
    //   'profileImage': await MultipartFile.fromFile(
    //     imageFile!.path,
    //     filename: 'image.jpg', // Replace with the desired filename on the server
    //   ),
    //   'fullName': data['fullName'],
    //   'email': data['email'],
    //   'phone': data['phone'],
    //   'password': data['password'],
    //   'address': data['address'],
    //   'fcmToken': data['fcmToken'],
    // });

    //print("The form data is:"+formData.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
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

  login({data}) async {
    var url = static.baseURL + static.authURL + static.signin;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${static.bearerToken}',
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

  forgetPassword({data}) async {
    var url = static.baseURL + static.authURL + static.forgetPassword;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
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

  verifyingOTP({data}) async {
    var url = static.baseURL + static.authURL + static.verifyingOTP;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
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

  resendOTP({data}) async {
    var url = static.baseURL + static.authURL + static.resendOTP;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
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

  changingPassword({data}) async {
    var url = static.baseURL + static.authURL + static.changePassword;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${static.bearerToken}',
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

  deleteAccount({data}) async {
    var url = static.baseURL + static.authURL + static.deleteAccount;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          // data: data, // Use the query string here
          options: Options(
            headers: {
              'x-auth-token': 'Bearer ${generalWatch.userTokenValue}',
              'access-token': '${generalWatch.userTokenValue}',
              'user-identity': '${generalWatch.userIDValue}',
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

  logout({data}) async {
    var url = static.baseURL + static.authURL + static.logout;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data, // Use the query string here
          options: Options(
            headers: {
              'x-auth-token': 'Bearer ${generalWatch.userTokenValue}',
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
}

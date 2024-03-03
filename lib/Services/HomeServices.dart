import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class HomeApisServices {
  Dio dio = Dio();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  categoryListing({data}) async {
    var url = static.baseURL + static.productURL + static.listCategories;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());
    print(static.xAuthToken.toString());

    try {
      Response response = await dio
          .get(url,
              data: data,
              options: Options(
                headers: {
                  'user-identity': '${generalWatch.userIDValue}',
                  'access-token': '${generalWatch.userTokenValue}',
                  'X-auth-token': '${static.xAuthToken}',
                },
              ))
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
        // final snackBar = SnackBar(
        //   content: Text('Internet Error: Check Internet Connection'),
        // );
        // ScaffoldMessenger.of(navigatorkey.currentContext!).showSnackBar(snackBar);
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  productListing({data}) async {
    var url = static.baseURL + static.productURL + static.listProducts;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());
    print(static.xAuthToken.toString());

    try {
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
        // final snackBar = SnackBar(
        //   content: Text('Internet Error: Check Internet Connection'),
        // );
        // ScaffoldMessenger.of(navigatorkey.currentContext!).showSnackBar(
        //     snackBar);
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  productDetail({data}) async {
    var url = static.baseURL + static.productURL + static.detail;
    print(url.toString());

    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());
    print(static.xAuthToken.toString());

    try {
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("response product details api: ${response.data}");
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
        // final snackBar = SnackBar(
        //   content: Text('Internet Error: Check Internet Connection'),
        // );
        // ScaffoldMessenger.of(navigatorkey.currentContext!).showSnackBar(
        //     snackBar);
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  tattooAndGraphicGeneration({data}) async {
    var url = static.tattooAndGraphicGenerationURL;
    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${static.openDalleToken}',
            },
          ));
      if (response.statusCode == 200) {
        return json.encode(response.data);
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

  variationGroup({data}) async {
    var url = static.baseURL + static.productURL + static.getVariationPrice;
    print(url.toString());

    try {
      Response response = await dio.get(
        url,
        data: data,
        options: Options(
          headers: {
            'user-identity': '${generalWatch.userIDValue}',
            'access-token': '${generalWatch.userTokenValue}',
            'X-auth-token': '${static.xAuthToken}',
          },
        ),
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
}

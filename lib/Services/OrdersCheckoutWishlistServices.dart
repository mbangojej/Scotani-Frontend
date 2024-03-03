import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class OrdersCheckoutWishlistServices {
  Dio dio = Dio();
  var static = Statics();
  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  wishList() async {
    var url = static.baseURL + static.wishlistURL + static.list;
    print(url.toString());

    try {
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
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  makeAndRemoveWishList({data}) async {
    var url = static.baseURL + static.wishlistURL + static.addToWishlist;
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

  orderListing(data) async {
    var url = static.baseURL + static.orderURL + static.history;
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

  reOrder({data}) async {
    var url = static.baseURL + static.orderURL + static.reOrder;
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

  orderDetail({id}) async {
    var url = static.baseURL + static.orderURL + static.detail + "s" + "/$id";
    print(url.toString());

    try {
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
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  deleteOrder({data}) async {
    var url = static.baseURL + static.orderURL + static.delete;
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

  cancelOrder({data}) async {
    var url = static.baseURL + static.orderURL + static.cancelOrder;
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

  addToCart({data}) async {
    var url = static.baseURL + static.cart + static.addToCart;

    print(url.toString());

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              'user-identity': '${generalWatch.userIDValue}',
              'access-token': '${generalWatch.userTokenValue}',
              'X-auth-token': '${static.xAuthToken}',
            },
          ));

      print("The response code is:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioError catch (e) {
      print(e);
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  cartListing({data}) async {
    var url = static.baseURL + static.cart + static.list;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());

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
        print("Cart List Api Response ${response.data}");
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

  sizeGroup({data}) async {
    var url = static.baseURL + static.orderURL + static.sizeGroup;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());

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

  updateCart({data}) async {
    var url = static.baseURL + static.cart + static.updateCart;
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

  removeCart({data}) async {
    var url = static.baseURL + static.cart + static.removeCart;
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

  checkout() async {
    var url = static.baseURL + static.orderURL + static.checkout;
    print(url.toString());

    try {
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
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  confirmTransaction(data) async {
    var url = static.baseURL + static.orderURL + static.confirmTransaction;
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

  validateCoupan(data) async {
    var url = static.baseURL + static.cart + static.validateCoupan;
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

  designImprint() async {
    var url = static.baseURL + static.imprint + static.list;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());

    try {
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
    } on DioError catch (e) {
      if (e.response == null) {
        print("Error Check Internet Connection");
      } else {
        print("Error + ${e.response}");
      }
      return null;
    }
  }

  getColorFromSize(data) async {
    var url = static.baseURL + static.productURL + static.getColors;
    print(url.toString());
    print(generalWatch.userIDValue.toString());
    print(generalWatch.userTokenValue.toString());

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
}

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Models/MDPaypal.dart';
import 'package:skincanvas/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPayPal extends StatefulWidget {
  String? amount;
  WebViewPayPal(this.amount);

  @override
  State<WebViewPayPal> createState() => _WebViewPayPalState();
}

class _WebViewPayPalState extends State<WebViewPayPal> {
  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor.lightBlackColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('PayPal'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          orderWatch.controller != null
              ? WebViewWidget(controller: orderWatch.controller!)
              : SizedBox(),
          orderWatch.isShowOverlyLayout
              ? Container(
                  height: static.height,
                  width: static.width,
                  color: Colors.white,
                )
              : Container(),
          payPalLoader(),
        ],
      ),
      // floatingActionButton: favoriteButton(),
    );
  }

  Widget payPalLoader() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return orderWatch.isShow
        ? Container(
            width: width,
            height: height,
            color: themeColor.blackColor.withOpacity(.4),
            child: Center(
              child: Lottie.asset(
                'assets/JSON/Loading Animation.json',
                height: 170.w,
                width: 170.w,
                fit: BoxFit.contain,
              ),
            ),
          )
        : const SizedBox();
  }

  // ...................... New Implementation ...................... //

  getAccessToken() async {

    //   //<........ Scotani SandBox Credentials.........>
    // String username =
    //     'ATBV7KdKvDd9sGHYL4hr9rPyV_Tcbqrkm2JKJpNyQL_8hZ0KLj6PkS0-hQixBcLzgTe83WmDThWAorkp';
    // String password =
    //     'EEitYKcFpiUCXplgxm1FTWtHJYsK-lsTGgodQyXR1JVRZfKE_nrePnrD1CZDIfKpqdXDYBLZSrt0Ic7L';



    // <............ Scotani Live Credentials ...........>

    String username =
        "AUtjVQ8kFRSoJ4QAjx5gHUbECflBSLVUyCBPM8ZdOcTB4iVr1LNccvWPFxm80JIwt3O-u-wpNDjt_oOw";
    String password =
        "EAIfC-8l48p1133xYu3h5oJOz6PFYV9CfCuusXGWXCbHw3KFzGYU87ZAfffLBhl-XEWjvoKaVqgN3AT7";

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$username:$password')),
    };
    var data = {
      'grant_type': 'client_credentials',
      'ignoreCache': 'true',
      'return_authn_schemes': 'true',
      'return_client_metadata': 'true',
      'return_unconsented_scopes': 'true'
    };
    var dio = Dio();
    var response = await dio.request(
      // 'https://api-m.sandbox.paypal.com/v1/oauth2/token',            // < SandBox >

      'https://api.paypal.com/v1/oauth2/token',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      orderRead.showProgressDialog(false);
      print(json.encode(response.data));
      Map<String, dynamic> mapppedResponse = response.data;
      print('Mapped Response ${mapppedResponse}');
      print("Paypal access Token ==> " + mapppedResponse['access_token']);
      orderRead.updateAccestoken(value: mapppedResponse['access_token']);
      orderWatch.PayPalRequestId = await generateRandomString();
      print("PayPalRequestId ${orderWatch.PayPalRequestId}");
      await createOrder();
    } else {
      print(response.statusMessage);
      orderRead.showProgressDialog(false);
    }
  }

  createOrder() async {
    var headers = {
      'Content-Type': 'application/json',
      'PayPal-Request-Id': orderWatch.PayPalRequestId.trim(),
      'Authorization': 'Bearer ${orderWatch.accessToken}',
    };
    print("Header ${headers}");
    var data = json.encode({
      "intent": "CAPTURE",
      "purchase_units": [
        {
          "items": [
            {
              "name": "T-Shirt",
              "description": "Green XL",
              "quantity": "1",
              "unit_amount": {
                "currency_code": "CAD",
                "value": "${widget.amount}"
              }
            }
          ],
          "amount": {
            "currency_code": "CAD",
            "value": "${widget.amount}",
            "breakdown": {
              "item_total": {
                "currency_code": "CAD",
                "value": "${widget.amount}"
              }
            }
          }
        }
      ],
      "application_context": {
        "return_url": "https://example.com/return",
        "cancel_url": "https://example.com/cancel"
      }
    });
    var dio = Dio();
    var response = await dio.request(
      // 'https://api-m.sandbox.paypal.com/v2/checkout/orders',     // < Sandbox >

      'https://api.paypal.com/v2/checkout/orders',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 201) {
      orderRead.showProgressDialog(false);
      print(json.encode(response.data));
      Map<String, dynamic> mapppedResponse = response.data;

      print("Create Order Response ${mapppedResponse}");

      orderRead.updateOrderId(value: mapppedResponse['id']);

      print("orderID ${orderWatch.orderID}");

      print("href ${(mapppedResponse['links'] as List)[1]['href']}");

      webViewClass(url: (mapppedResponse['links'] as List)[1]['href']);
    } else {
      print(response.statusMessage);
      orderRead.showProgressDialog(false);
    }
  }

  capturePayment() async {
    FocusScope.of(context).requestFocus(FocusNode());

    var url =
        // 'https://api-m.sandbox.paypal.com/v2/checkout/orders/${orderWatch.OrderID}/capture';     // < Sandbox >
        'https://api.paypal.com/v2/checkout/orders/${orderWatch.OrderID}/capture';

    print("URL ${url}");
    print("order ID ${orderWatch.OrderID}");
    try {
      orderRead.showProgressDialog(true);

      var headers = {
        'Content-Type': 'application/json',
        'PayPal-Request-Id': orderWatch.PayPalRequestId.trim(),
        'Authorization': 'Bearer ${orderWatch.accessToken}',
      };
      print("Header ${headers}");
      var data = '''''';
      var dio = Dio();
      var response = await dio.request(
        // 'https://api-m.sandbox.paypal.com/v2/checkout/orders/${orderWatch.OrderID}/capture',    //  < Sandbox >
        'https://api.paypal.com/v2/checkout/orders/${orderWatch.OrderID}/capture',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(json.encode(response.data));
        Map<String, dynamic> mapppedResponse = response.data;
        print("Mapped Response ${mapppedResponse}");

        MDPayPal paypalObj = MDPayPal(
            mapppedResponse['id'], orderWatch.token, orderWatch.payerId);

        Navigator.pop(context, paypalObj);
        orderRead.updateIsShowOverlyLayout(value: false);
      } else {
        print(response.statusMessage);
      }
    } catch (err) {
      print(err);
      orderRead.showProgressDialog(false);
    }
  }

  String generateRandomString() {
    final String charset = '0123456789abcdef'; // Define the character set
    final Random random = Random();
    final StringBuffer buffer = StringBuffer();

    // Generate the first part of the string
    for (int i = 0; i < 8; i++) {
      final randomIndex = random.nextInt(charset.length);
      buffer.write(charset[randomIndex]);
    }

    buffer.write('-');

    // Generate the second part of the string
    for (int i = 0; i < 4; i++) {
      final randomIndex = random.nextInt(charset.length);
      buffer.write(charset[randomIndex]);
    }

    buffer.write('-');

    // Generate the third part of the string
    for (int i = 0; i < 4; i++) {
      final randomIndex = random.nextInt(charset.length);
      buffer.write(charset[randomIndex]);
    }

    buffer.write('-');

    // Generate the fourth part of the string
    for (int i = 0; i < 4; i++) {
      final randomIndex = random.nextInt(charset.length);
      buffer.write(charset[randomIndex]);
    }

    buffer.write('-');

    // Generate the fifth part of the string
    for (int i = 0; i < 12; i++) {
      final randomIndex = random.nextInt(charset.length);
      buffer.write(charset[randomIndex]);
    }

    return buffer.toString();
  }

  webViewClass({String? url}) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            if (url.contains('PayerID=')) {
              orderRead.updateIsShowOverlyLayout(value: true);
              orderRead.updatePayerId(value: url.split('PayerID=')[1]);
              orderRead.updateToken(value: url.split('token=')[1]);
              orderRead.updateToken(
                  value: orderWatch.token.split('&PayerID=')[0]);
              // apiExecutePayment();
              capturePayment();
              print('-------Payer ID----------');
              print(orderWatch.payerId);
              print(orderWatch.token);
            }

            print("onPage Started Url ${url}");

            if (!url.contains('signin?intent=checkout')) {
              orderRead.showProgressDialog(true);
            }
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print("page finished url ${url}");
            if (!url.contains('PayerID=')) {
              orderRead.showProgressDialog(false);
            }
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(url!));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    orderRead.updateController(value: controller);
    // _controller = controller;
  }
}

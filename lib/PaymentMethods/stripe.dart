import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/main.dart';

class StripeMethods {
  // var orderRead = navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();
  var orderRead = Provider.of<OrderCheckOutWishlistController>(
      navigatorkey.currentContext!,
      listen: false);

  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Map<String, dynamic>? paymentIntentData;
  // String STRIPE_SECRET_KEY =
  //     'sk_test_51NlGTQBbUgQFBELTndE403cbvx2GyexzCxSBerAv188pEVclfhJ7IOpXmE5w8XHY99wwedFj6HbQimnwEITUIrN800A2CaH1D5';

  String STRIPE_SECRET_KEY =
      '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';

  Future<void> makePayment({payment}) async {
    generalRead.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Loading..', maskType: EasyLoadingMaskType.black);

    // Stripe.publishableKey =
    //     'pk_test_51NlGTQBbUgQFBELT3On0Mdjbw8lANuVUOIje9ejuEC8hO7EW2uxffa4lVklvufkhuwkwvkKA7PNqug4x2naEKs6700phH3HXSh';

    Stripe.publishableKey =
        'pk_live_51NyFs4KkstOWKaEKiyNawqiIk1XGJnFMXXkLH7cp52duCxboS6J6T0dyEsbT6Iv1FEffgURUf2QNSPp3AE7LnRWD00vACDV9qN';
    try {
      paymentIntentData = await createPaymentIntent('$payment', 'CAD');

      // var gPay = PaymentSheetGooglePay(
      //   currencyCode: 'USD', // Change to the currency you are using
      //   merchantCountryCode: 'US', // Change to your country code
      //   testEnv: true, // Make sure it's set to true for testing
      // );

      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Scotani',
          // googlePay: gPay,
        ),
      )
          .then((value) {
        // print('Stripe =============> ${value}');

        displayPaymentSheet();
      });

      ///now finally display payment sheeet
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      EasyLoading.dismiss();
      await Stripe.instance.presentPaymentSheet().then((value) {
        String paymentIntentID = paymentIntentData!["id"].toString();
        print(
            'Payment Successful! Payment Intent ID: ${paymentIntentData!["id"].toString()}');

        print("Stripe Map data ${paymentIntentData}");

        if (orderRead.isFromOrderDetail) {
          orderRead.reOrderApi(navigatorkey.currentContext,
              orderID: orderRead.orderID, transactionID: paymentIntentID);
        } else {
          orderRead.checkoutApi(navigatorkey.currentContext,
              transactionID: paymentIntentID);
        }
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      EasyLoading.dismiss();
      showDialog(
          context: navigatorkey.currentContext!,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
      EasyLoading.dismiss();
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${STRIPE_SECRET_KEY}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  // calculateAmount(String amount) {
  //   final calculatedAmout = (int.parse(amount)) * 100;
  //   return calculatedAmout.toString();
  // }

  String calculateAmount(String amount) {
    try {
      final parsedAmount = double.parse(amount);
      final cents = (parsedAmount * 100).toInt();
      return cents.toString();
    } catch (e) {
      print('Error parsing amount: $e');
      return '0';
    }
  }
}

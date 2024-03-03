import 'package:pay/pay.dart';

class GoogleAndApplePay {
  final paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: "15.0",
      status: PaymentItemStatus.final_price,
    )
  ];

  Pay payClient = Pay.withAssets(['JSON/gpay.json', 'JSON/applepay.json']);

  Future<void> initGooglePayPayment({
    serviceType,
    needToPayAmount,
    serviceName,
  }) async {
    await payClient.showPaymentSelector(PayProvider.google_pay, [
      PaymentItem(
        label: 'Payment for $serviceName $serviceType pack',
        amount: needToPayAmount.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      )
    ]).then(
      (value) {
        var token = value['paymentMethodData']['tokenizationData']['token'];
        print("=====--=-=-=->>>${token}");
      },
    );
  }

  Future<void> initApplePayPayment({
    serviceType,
    needToPayAmount,
    serviceName,
  }) async {
    await payClient.showPaymentSelector(PayProvider.apple_pay, [
      PaymentItem(
        label: 'Payment for $serviceName $serviceType pack',
        amount: needToPayAmount.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      )
    ]).then(
      (value) {
        var token = value['paymentMethodData']['tokenizationData']['token'];
        print("=====--=-=-=->>>${token}");
      },
    );
  }
}

transaction(double paymentPrice, String serviceName, String serviceType) {
  Map<String, dynamic> transactions = {
    "intent": "sale",
    "payer": {
      "payment_method": "paypal",
    },
    "redirect_urls": {
      "return_url": "https://samplesite.com/return",
      "cancel_url": "https://samplesite.com/cancel",
    },
    'transactions': [
      {
        "amount": {
          "total": paymentPrice ?? '',
          "currency": "BRL",
          "details": {
            "subtotal": paymentPrice ?? '',
            "shipping": '0',
            "shipping_discount": 0
          }
        },
        "description":
            "The payment transaction for purchase of $serviceName $serviceType pack..",
        "item_list": {
          "items": [
            {
              "name": serviceName,
              "quantity": 1,
              "price": paymentPrice,
              "currency": "BRL"
            }
          ],
        }
      }
    ],
  };

  return transactions;
}

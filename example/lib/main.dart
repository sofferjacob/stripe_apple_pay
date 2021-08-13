import 'package:flutter/material.dart';
import 'package:stripe_apple_pay/stripe_apple_pay.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    StripeApplePay.instance.setPublishableKey("YOUR_PUBLISHABLE_KEY");
    StripeApplePay.instance.setMerchantIdentifier("YOUR_MERCHANT_IDENTIFIER");
  }

  _applePayPayment() async {
    final order = ApplePayOrder(
      merchantName: 'Some Store',
      items: [
        ApplePayItem(label: 'Foo', amount: 1.50),
        ApplePayItem(label: 'Bar', amount: 3.00),
      ],
      tax: 0.27,
    );
    final token = await StripeApplePay.instance.presentApplePay(order);
    // Send this token to Stripe here to complete your purchase
    StripeApplePay.instance.confirmPayment(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ApplePayButton(
          onPressed: _applePayPayment,
        ),
      ),
    );
  }
}

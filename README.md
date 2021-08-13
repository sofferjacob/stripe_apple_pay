# Stripe Apple Pay

#### Create chargeable stripe tokens using Apple Pay.

This plugin allows you to easily charge a user using Apple Pay and get a token that can be sent to Stripe to complete the purchase.

## Setup

### iOS Merchant Identifier

On the Apple Developer portal, create a merchant identifier. This identifier will need to be associated with
your Stripe project and added to your projects capabilities in Xcode. Check out [Stripe's documentation](https://stripe.com/docs/payments/accept-a-payment?platform=ios&ui=payment-sheet#apple-pay)
for detailed instructions.

### Set Publishable Key

Setting your project's publishable key is required before calling any of the plugin's methods.

```dart
StripeApplePay.instance.setPublishableKey("YOUR_STRIPE_PUBLISHABLE_KEY");
```

### Set Merchant Identifier

Setting your merchant identifier is required before calling any of the plugin's methods.

```dart
StripeApplePay.instance.setMerchantIdentifier("YOUR_MERCHANT_IDENTIFIER");
```

### Set Currency Key (optional)

You can change the currency used in the payment sheet by calling the following methods and passing a ISO currency and country code
```dart
StripeApplePay.instance.setCurrencyKey("MXN");
StripeApplePay.instance.setCountryKey("MX");
```

## Collect payments

To collect a payment create an order containing the order items, merchant name, and optionally a tax or tip. Call `presentApplePay` to present the payment sheet to the user.
This function will return a token, which can be sent to Stripe to complete the purchase. Once the purchase has been completed call `confirmPayment` to let the user know wether the
purchase was successful.

```dart
import 'package:stripe_apple_pay/stripe_apple_pay.dart';

// ...
@override
Widget build(context) {
    // ApplePayButton is optional
    return ApplePayButton(
        onPressed: () async {
            final order = ApplePayOrder(merchantName: 'Hat Store', items: [ApplePayItem(label: 'Top Hat', amount: 5.00)]);
            final token = await StripeNative.useNativePay(order);
            // Send token to stripe to complete the purchase
            StripeApplePay.instance.confirmPayment(true);
        }
    );
}

```

## Google Pay
I suggest using the [pay](https://pub.dev/packages/pay) package to use Google Pay with Stripe.

## Acknowledgments
This plugin uses code from the following packages:
* [pay](https://pub.dev/packages/pay)
* [stripe_native](https://pub.dev/packages/stripe_native)

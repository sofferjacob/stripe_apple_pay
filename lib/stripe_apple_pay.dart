import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'widgets/apple_pay_button.dart';

/// Used to explain the different charges in a native payment sheet
class ApplePayItem {
  final String label;
  final double amount;

  ApplePayItem({required this.label, required this.amount});

  Map<String, double> toMap() => {
        label: amount,
      };

  ApplePayItem copyWith({String? label, double? amount}) {
    return ApplePayItem(
        label: label ?? this.label, amount: amount ?? this.amount);
  }
}

/// Parameters used to present a native payment sheet to the user
class ApplePayOrder {
  /// Charges presented in the native payment sheet
  final List<ApplePayItem> items;
  final String merchantName;
  final double? tax;
  final double? tip;

  ApplePayOrder({
    required this.items,
    required this.merchantName,
    this.tax,
    this.tip,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = {
      'merchantName': merchantName,
      'subtotal': -1,
      'tax': -1,
      'tip': -1,
    };
    double subtotal = 0;
    items.forEach((element) {
      res.addAll(element.toMap());
      subtotal += element.amount;
    });
    if (tax != null || tip != null) {
      res['subtotal'] = subtotal;
    } else {
      return res;
    }
    if (tax != null) {
      res['tax'] = tax;
    }
    if (tip != null) {
      res['tip'] = tip;
    }
    return res;
  }
}

class StripeApplePay {
  StripeApplePay._();

  static final StripeApplePay _instance = StripeApplePay._();
  static StripeApplePay get instance => _instance;

  MethodChannel _channel = const MethodChannel('stripe_native');

  String publishableKey = "";
  String merchantIdentifier = "";
  bool get nativePayReady =>
      merchantIdentifier.isNotEmpty && publishableKey.isNotEmpty;
  String currencyKey = "";
  String countryKey = "";

  /// Call this method before using the library.
  /// Sets the Stripe publishable key for your project
  void setPublishableKey(String key) {
    _channel.invokeMethod("setPublishableKey", key);
    publishableKey = key;
  }

  /// Call this method before using the library.
  /// Sets the Apple Pay merchant identifier
  void setMerchantIdentifier(String identifier) {
    _channel.invokeMethod('setMerchantIdentifier', identifier);
    merchantIdentifier = identifier;
  }

  void setCurrencyKey(String key) {
    _channel.invokeMethod('setCurrencyKey', key);
    currencyKey = key;
  }

  void setCountryKey(String key) {
    _channel.invokeMethod('setCountryKey', key);
    countryKey = key;
  }

  /// Presents a native payment sheet to the user and
  /// returns a token that can be sent to Stripe to
  /// complete a payment
  Future<String> presentApplePay(ApplePayOrder order) async {
    final String nativeToken =
        await _channel.invokeMethod('presentApplePay', order.toMap());
    return nativeToken;
  }

  /// Indicates to the user if the payment was successful on the payment sheet
  /// Pass true to indicate a successful payment, false otherwise
  void confirmPayment(bool isSuccess) =>
      _channel.invokeMethod("confirmPayment", isSuccess);
}

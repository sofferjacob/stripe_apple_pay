#import "StripeNativePlugin.h"
#import <stripe_apple_pay/stripe_apple_pay-Swift.h>

@implementation StripeNativePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStripeNativePlugin registerWithRegistrar:registrar];
}
@end

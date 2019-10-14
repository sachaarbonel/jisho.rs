#import "JishoPlugin.h"
#import <jisho/jisho-Swift.h>

@implementation JishoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJishoPlugin registerWithRegistrar:registrar];
}
@end

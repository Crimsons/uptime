#import "UptimePlugin.h"
#import <uptime/uptime-Swift.h>

@implementation UptimePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUptimePlugin registerWithRegistrar:registrar];
}
@end

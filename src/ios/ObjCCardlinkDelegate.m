#import "ObjCCardlinkDelegate.h"
#import <CardlinkSDK/CardlinkSDK.h>

@implementation ObjCCardlinkDelegate

- (void)cardlinkDidChangeState:(CSDKCardlinkState *)state
{
    
}

- (void)cardlinkDidUpdateProgress:(int32_t)progress
{
    
}

- (void)cardlinkDidFetchPrescriptionTokens:(NSString *)tokens
{
    
}

- (void)cardlinkDidFetchPrescriptionBundles:(NSArray<NSString *> *)bundles
{
    
}

- (void)cardlinkDidEncounterError:(CSDKCardlinkError *)error message:(NSString *)message expectedAction:(CSDKCardlinkAction *)expectedAction
{
    
}

@end

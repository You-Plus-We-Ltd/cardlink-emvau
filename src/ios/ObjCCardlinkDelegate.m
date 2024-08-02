#import "ObjCCardlinkDelegate.h"
#import <CardlinkSDK/CardlinkSDK.h>
#import "CardlinkPlugin.h"

@implementation ObjCCardlinkDelegate

- (void)cardlinkDidChangeState:(CSDKCardlinkState *)state
{
    CDVPluginResult* pluginResult = nil;
    
    if (state != nil) {
        CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
        NSString* onStateChangedCallbackId = [CardLinkPlugin onStateChangedCallbackId];
        NSDictionary* stateResponse = @{ state: state };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:stateResponse];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onStateChangedCallbackId];
    }
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

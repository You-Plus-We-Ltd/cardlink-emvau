#import "ObjCCardlinkDelegate.h"
#import <CardlinkSDK/CardlinkSDK.h>
#import "CardlinkPlugin.h"

@implementation ObjCCardlinkDelegate

- (void)cardlinkDidChangeState:(CSDKCardlinkState *)state
{
    CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
    NSString* onStateChangedCallbackId = [CardLinkPlugin onStateChangedCallbackId];
    CDVPluginResult* pluginResult = nil;
    
    if (cardLinkPluginObject != nil && onStateChangedCallbackId != nil) {
        NSDictionary* stateResponse = @{ @"state": [state name] };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:stateResponse];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onStateChangedCallbackId];
    }
}

- (void)cardlinkDidUpdateProgress:(int32_t)progress
{
    CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
    NSString* onProgressUpdateCallbackId = [CardLinkPlugin onProgressUpdateCallbackId];
    CDVPluginResult* pluginResult = nil;
    
    if (cardLinkPluginObject != nil && onProgressUpdateCallbackId != nil) {
        NSDictionary* progressResponse = @{ @"progress": [NSNumber numberWithInt:progress] };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:progressResponse];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onProgressUpdateCallbackId];
    }
}

- (void)cardlinkDidFetchPrescriptionTokens:(NSString *)tokens
{
    CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
    NSString* onPrescriptionTokensCallbackId = [CardLinkPlugin onPrescriptionTokensCallbackId];
    CDVPluginResult* pluginResult = nil;
    
    if (cardLinkPluginObject != nil && onPrescriptionTokensCallbackId != nil) {
        NSDictionary* tokensResponse = @{ @"tokens": tokens };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:tokensResponse];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onPrescriptionTokensCallbackId];
    }
}

- (void)cardlinkDidFetchPrescriptionBundles:(NSArray<NSString *> *)bundles
{
    CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
    NSString* onPrescriptionBundlesCallbackId = [CardLinkPlugin onPrescriptionBundlesCallbackId];
    CDVPluginResult* pluginResult = nil;
    
    if (cardLinkPluginObject != nil && onPrescriptionBundlesCallbackId != nil) {
        NSDictionary* bundlesResponse = @{ @"bundles": bundles };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:bundlesResponse];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onPrescriptionBundlesCallbackId];
    }
}

- (void)cardlinkDidEncounterError:(CSDKCardlinkError *)error message:(NSString *)message expectedAction:(CSDKCardlinkAction *)expectedAction
{
    CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
    NSString* onErrorCallbackId = [CardLinkPlugin onErrorCallbackId];
    CDVPluginResult* pluginResult = nil;
    
    if (cardLinkPluginObject != nil && onErrorCallbackId != nil) {
        NSDictionary* errorResponse = [NSDictionary dictionaryWithObjectsAndKeys: [error name], @"error", message, @"message", [expectedAction name], @"expectedAction", nil];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:errorResponse];
        [pluginResult setKeepCallbackAsBool:YES];
        
        [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onErrorCallbackId];
    }
}

@end

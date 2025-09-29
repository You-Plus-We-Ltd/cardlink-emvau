#import "ObjCCardlinkDelegate.h"
#import <CardlinkSDK/CardlinkSDK.h>
#import "CardlinkPlugin.h"

static NSTimer* timer = nil;

@implementation ObjCCardlinkDelegate

// - (void) doResult:(NSTimer *)timer
// {
//     NSDictionary* userInfo = timer.userInfo;
//     NSString* stateName = userInfo[@"stateName"];
//     CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
//     NSString* onStateChangedCallbackId = [CardLinkPlugin onStateChangedCallbackId];
//     CDVPluginResult* pluginResult = nil;
//     NSMutableArray* passedIds = [CardLinkPlugin passedIds];
    
//     if (passedIds == nil) {
//         passedIds = [[NSMutableArray alloc] init];
//     }
    
//     NSLog(@"TEST-DEBUG: State changed %@ callbackId: %@ passedIds length %lu", stateName, onStateChangedCallbackId, [passedIds count]);
    
//     if (![passedIds containsObject:onStateChangedCallbackId]) {
//         NSLog(@"EST-DEBUG inside %@", onStateChangedCallbackId);
//         [passedIds addObject:onStateChangedCallbackId];
//         if (cardLinkPluginObject != nil && onStateChangedCallbackId != nil) {
//             NSDictionary* stateResponse = @{ @"state": stateName, @"callbackId": onStateChangedCallbackId };
//             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:stateResponse];
//             [cardLinkPluginObject.commandDelegate sendPluginResult:pluginResult callbackId:onStateChangedCallbackId];
//         }
//         [CardLinkPlugin setPassedIds: passedIds];
//         [timer invalidate];
//         timer = nil;
//     }
// }

- (void)cardlinkDidChangeState:(CSDKCardlinkState *)state
{
   CardLinkPlugin* cardLinkPluginObject = [CardLinkPlugin cardLinkPluginObject];
   NSString* onStateChangedCallbackId = [CardLinkPlugin onStateChangedCallbackId];
   CDVPluginResult* pluginResult = nil;
    
//    NSLog(@"TEST-DEBUG: State changed %@ callbackId: %@", [state name], onStateChangedCallbackId);
    
    // timer = [NSTimer scheduledTimerWithTimeInterval:0.100
    //                                          target:self
    //                                        selector:@selector(doResult:)

    //                                        userInfo:@{@"stateName": [state name]}
    //                                         repeats:YES];
    
   if (cardLinkPluginObject != nil && onStateChangedCallbackId != nil) {
       NSDictionary* stateResponse = @{ @"state": [state name], @"callbackId": onStateChangedCallbackId };
       [pluginResult setKeepCallbackAsBool:YES];
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

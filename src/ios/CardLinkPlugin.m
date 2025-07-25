#import "CardLinkPlugin.h"
#import "ObjCCardlinkDelegate.h"
#import <Cordova/CDVPlugin.h>
#import <CardlinkSDK/CardlinkSDK.h>

static CardLinkPlugin* cardLinkPluginObject = nil;
static ObjCCardlinkDelegate* objCCardlinkDelegate = nil;
static NSString* OnStateChangedCallbackId = nil;
static NSString* OnProgressUpdateCallbackId = nil;
static NSString* OnPrescriptionTokensCallbackId = nil;
static NSString* OnPrescriptionBundlesCallbackId = nil;
static NSString* OnErrorCallbackId = nil;
static NSMutableArray* PassedIds = nil;

@implementation CardLinkPlugin

+ (NSMutableArray*) passedIds
{
    return PassedIds;
}

+ (void)setPassedIds:(NSMutableArray *)newPassedIds
{
    PassedIds = newPassedIds;
}

+ (ObjCCardlinkDelegate*)objCCardlinkDelegate
{
    return objCCardlinkDelegate;
}

+ (void)setObjCCardlinkDelegate:(ObjCCardlinkDelegate*)newObjCCardlinkDelegate
{
    objCCardlinkDelegate = newObjCCardlinkDelegate;
}

+ (CardLinkPlugin*)cardLinkPluginObject
{
    return cardLinkPluginObject;
}

+ (void)setCardLinkPluginObject:(CardLinkPlugin*)newCardLinkPluginObject
{
    if (cardLinkPluginObject != newCardLinkPluginObject) {
        cardLinkPluginObject = newCardLinkPluginObject;
    }
}

+ (NSString*)onStateChangedCallbackId
{
    return OnStateChangedCallbackId;
}

+ (void)setOnStateChangedCallbackId:(NSString*)newOnStateChangedCallbackId
{
    NSLog(@"TEST-DEBUG: OnStateChangedCallbackId  %@", OnStateChangedCallbackId);
    NSLog(@"TEST-DEBUG: newOnStateChangedCallbackId  %@", newOnStateChangedCallbackId);
    NSLog(@"TEST-DEBUG: -------------------------------------------");
    if (OnStateChangedCallbackId != newOnStateChangedCallbackId) {
        OnStateChangedCallbackId = newOnStateChangedCallbackId;
    }
}

+ (NSString*)onProgressUpdateCallbackId
{
    return OnProgressUpdateCallbackId;
}

+ (void)setOnProgressUpdateCallbackId:(NSString*)newOnProgressUpdateCallbackId
{
    if (OnProgressUpdateCallbackId != newOnProgressUpdateCallbackId) {
        OnProgressUpdateCallbackId = newOnProgressUpdateCallbackId;
    }
}

+ (NSString*)onPrescriptionTokensCallbackId
{
    return  OnPrescriptionTokensCallbackId;
}

+ (void)setOnPrescriptionTokensCallbackId:(NSString*)newOnPrescriptionTokensCallbackId
{
    if (OnPrescriptionTokensCallbackId != newOnPrescriptionTokensCallbackId) {
        OnPrescriptionTokensCallbackId = newOnPrescriptionTokensCallbackId;
    }
}

+ (NSString*)onPrescriptionBundlesCallbackId
{
    return  OnPrescriptionBundlesCallbackId;
}

+ (void)setOnPrescriptionBundlesCallbackId:(NSString*)newOnPrescriptionBundlesCallbackId
{
    if (OnPrescriptionBundlesCallbackId != newOnPrescriptionBundlesCallbackId) {
        OnPrescriptionBundlesCallbackId = newOnPrescriptionBundlesCallbackId;
    }
}

+ (NSString*) onErrorCallbackId
{
    return OnErrorCallbackId;
}

+ (void)setOnErrorCallbackId:(NSString*)newOnErrorCallbackId
{
    if (OnErrorCallbackId != newOnErrorCallbackId) {
        OnErrorCallbackId = newOnErrorCallbackId;
    }
}

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString* cardlinkServerUrl = [command.arguments objectAtIndex:0];
        NSString* authToken = [command.arguments objectAtIndex:1];
        [CardLinkPlugin setCardLinkPluginObject:self];
        
        // if (objCCardlinkDelegate == nil) {
            [CardLinkPlugin setObjCCardlinkDelegate:[[ObjCCardlinkDelegate alloc] init]];
        /// }
        
        if (cardlinkServerUrl != nil && [cardlinkServerUrl length] > 0 && authToken != nil && [authToken length] > 0) {
            [CSDKCardlink.shared initializeWithCardlinkServerUrl:cardlinkServerUrl delegate:[[ObjCCardlinkDelegate alloc] init] authToken:authToken];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"init started"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)requestSmsToken:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString *phoneNumber = [command.arguments objectAtIndex:0];
        NSString *smsSenderId = [command.arguments objectAtIndex:1];
        NSString *smsTextTemplate = [command.arguments objectAtIndex:2];
        NSString *smsTextReassignmentTemplate = [command.arguments objectAtIndex:3];
        
        // TODO remove smsTextTemplate and smsTextReassignmentTemplate logic
        if (smsSenderId != nil && [smsSenderId length] > 0 && smsSenderId != nil && [smsSenderId length] > 0 && smsTextTemplate != nil && smsTextReassignmentTemplate != nil) {
            [CSDKCardlink.shared requestSmsTokenWithPhoneNumber:phoneNumber
                smsSenderId:smsSenderId
                smsTextTemplate:smsTextTemplate
                smsTextReassignmentTemplate:smsTextReassignmentTemplate];
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"sms sent"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)verifySmsToken:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSNumber* smsTokenNumber = [command.arguments objectAtIndex:0];
        NSString* smsToken = nil;
        
        if (smsTokenNumber != nil) {
            smsToken = [smsTokenNumber stringValue];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        if (smsToken != nil && [smsToken length] > 0) {
            [CSDKCardlink.shared verifySmsToken:smsToken];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"verify sms token"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)startScan:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString* can = [command.arguments objectAtIndex:0];
        NSString* message = @"Scanning...";
        
        if (can != nil && [can length] > 0) {
            [CSDKCardlink.shared startScanWithMessage:message can:can];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@ %@", @"starting scan with can", can]];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)stopScan:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        
        [CSDKCardlink.shared stopScan];

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"scan stopped"];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)updateNfcMessage:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString* message = [command.arguments objectAtIndex:0];
        
        if (message != nil && [message length] > 0) {
            [CSDKCardlink.shared updateNfcMessage:message];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"message sent"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)shutdown:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        [CSDKCardlink.shared shutdown];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"shutdown started"];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)onStateChanged:(CDVInvokedUrlCommand *)command
{
    [CardLinkPlugin setCardLinkPluginObject:self];
    [CardLinkPlugin setOnStateChangedCallbackId:command.callbackId];
}

- (void)onProgressUpdate:(CDVInvokedUrlCommand *)command
{
    [CardLinkPlugin setCardLinkPluginObject:self];
    [CardLinkPlugin setOnProgressUpdateCallbackId:command.callbackId];
}

- (void)onPrescriptionTokens:(CDVInvokedUrlCommand *)command
{
    [CardLinkPlugin setCardLinkPluginObject:self];
    [CardLinkPlugin setOnPrescriptionTokensCallbackId:command.callbackId];
}

- (void)onPrescriptionBundles:(CDVInvokedUrlCommand *)command
{
    [CardLinkPlugin setCardLinkPluginObject:self];
    [CardLinkPlugin setOnPrescriptionBundlesCallbackId:command.callbackId];
}

- (void)onError:(CDVInvokedUrlCommand *)command
{
    [CardLinkPlugin setCardLinkPluginObject:self];
    [CardLinkPlugin setOnErrorCallbackId:command.callbackId];
}

- (void)setSmsEnabled:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
    CDVPluginResult* pluginResult = nil;
    BOOL enabled = [command.arguments objectAtIndex:0];

    if (enabled != nil) {
        CSDKCardlink.shared.smsEnabled = enabled;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"sms enabled value set"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setDebug:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
    CDVPluginResult* pluginResult = nil;
    BOOL enabled = [command.arguments objectAtIndex:0];

    if (enabled != nil) {
        [CSDKCardlink.shared setDebug:enabled];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"debug value set"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setLogLevel:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
    CDVPluginResult* pluginResult = nil;
    NSString* logLevel = [command.arguments objectAtIndex:0];
    if (logLevel != nil && [logLevel length] > 0) {
        
       if ([logLevel isEqual:@"NONE"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.none];
       } else if ([logLevel isEqual:@"DEBUG"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.debug];
       } else if ([logLevel isEqual:@"ERROR"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.error];
       } else if ([logLevel isEqual:@"WARNING"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.warning];
       } else if ([logLevel isEqual:@"INFO"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.info];
       } else if ([logLevel isEqual:@"DEBUG"]) {
           [CSDKCardlink.shared setLogLevel:CSDKLogLevel.debug];
       }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"log level value set"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
#import "CardLinkPlugin.h"
#import "ObjCCardlinkDelegate.h"
#import <Cordova/CDVPlugin.h>
#import <CardlinkSDK/CardlinkSDK.h>

static CardLinkPlugin* cardLinkPluginObject = nil;
static NSString* OnStateChangedCallbackId = nil;

@implementation CardLinkPlugin

+ (CardLinkPlugin*)cardLinkPluginObject {
    return cardLinkPluginObject;
}

+ (void)setCardLinkPluginObject:(CardLinkPlugin*)newCardLinkPluginObject {
    if (cardLinkPluginObject != newCardLinkPluginObject) {
        cardLinkPluginObject = newCardLinkPluginObject;
    }
}

+ (NSString*)onStateChangedCallbackId {
    return OnStateChangedCallbackId;
}

+ (void)setStateChangedCallbackId:(NSString*)newOnStateChangedCallbackId {
    if (OnStateChangedCallbackId != newOnStateChangedCallbackId) {
        OnStateChangedCallbackId = newOnStateChangedCallbackId;
    }
}

- (void)echo:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSString* cardlinkServerUrl = [command.arguments objectAtIndex:0];
        NSString* pkcs12Data = [command.arguments objectAtIndex:1];
        NSString* password = [command.arguments objectAtIndex:2];
        
        if (cardlinkServerUrl != nil && [cardlinkServerUrl length] > 0 && pkcs12Data != nil && [pkcs12Data length] > 0 && password != nil && [password length] > 0) {
            [CSDKCardlink.shared initializeWithCardlinkServerUrl:cardlinkServerUrl delegate:[[ObjCCardlinkDelegate alloc] init] pkcs12Data:pkcs12Data password:password];
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
        
        if (smsSenderId != nil && [smsSenderId length] > 0 && smsSenderId != nil && [smsSenderId length] > 0 && smsTextTemplate != nil && [smsTextTemplate length] > 0 && smsTextReassignmentTemplate != nil && [smsTextReassignmentTemplate length] > 0) {
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
        NSString* smsToken = [command.arguments objectAtIndex:0];
        
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
        
        if (can != nil && [can length] > 0) {
            [CSDKCardlink.shared startScanWithMessage:@"Scaning..." can:can];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"starting scan"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
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
    [CardLinkPlugin setStateChangedCallbackId:command.callbackId];
}

@end

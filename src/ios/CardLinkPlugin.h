#import <Cordova/CDVPlugin.h>

@interface CardLinkPlugin : CDVPlugin

+ (CardLinkPlugin*)cardLinkPluginObject;

+ (void)setCardLinkPluginObject:(CardLinkPlugin*)newCardLinkPluginObject;

+ (NSString*)onStateChangedCallbackId;

+ (void)setStateChangedCallbackId:(NSString*)newOnStateChangedCallbackId;

- (void)echo:(CDVInvokedUrlCommand*)command;

- (void)initialize:(CDVInvokedUrlCommand*)command;

- (void)requestSmsToken:(CDVInvokedUrlCommand*)command;

- (void)startScan:(CDVInvokedUrlCommand*)command;

- (void)updateNfcMessage:(CDVInvokedUrlCommand*)command;

- (void)shutdown:(CDVInvokedUrlCommand*)command;

- (void)onStateChanged:(CDVInvokedUrlCommand*)command;

@end

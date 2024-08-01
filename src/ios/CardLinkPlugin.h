#import <Cordova/CDVPlugin.h>

@interface CardLinkPlugin : CDVPlugin

- (void)echo:(CDVInvokedUrlCommand*)command;

- (void)initialize:(CDVInvokedUrlCommand*)command;

- (void)requestSmsToken:(CDVInvokedUrlCommand*)command;

- (void)startScan:(CDVInvokedUrlCommand*)command;

- (void)updateNfcMessage:(CDVInvokedUrlCommand*)command;

- (void)shutdown:(CDVInvokedUrlCommand*)command;

@end

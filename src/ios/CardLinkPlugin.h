#import <Cordova/CDVPlugin.h>

@interface CardLinkPlugin : CDVPlugin

+ (CardLinkPlugin*)cardLinkPluginObject;

+ (void)setCardLinkPluginObject:(CardLinkPlugin*)newCardLinkPluginObject;

+ (NSString*)onStateChangedCallbackId;

+ (void)setOnStateChangedCallbackId:(NSString*)newOnStateChangedCallbackId;

+ (NSString*)onProgressUpdateCallbackId;

+ (void)setOnProgressUpdateCallbackId:(NSString*)newOnProgressUpdateCallbackId;

+ (NSString*)onPrescriptionTokensCallbackId;

+ (void)setOnPrescriptionTokensCallbackId:(NSString*)newOnPrescriptionTokensCallbackId;

+ (NSString*)onPrescriptionBundlesCallbackId;

+ (void)setOnPrescriptionBundlesCallbackId:(NSString*)newOnPrescriptionBundlesCallbackId;

+ (NSString*)onErrorCallbackId;

+ (void)setOnErrorCallbackId:(NSString*) newOnErrorCallbackId;


- (void)initialize:(CDVInvokedUrlCommand*)command;

- (void)requestSmsToken:(CDVInvokedUrlCommand*)command;

- (void)startScan:(CDVInvokedUrlCommand*)command;

- (void)updateNfcMessage:(CDVInvokedUrlCommand*)command;

- (void)shutdown:(CDVInvokedUrlCommand*)command;

- (void)onStateChanged:(CDVInvokedUrlCommand*)command;

- (void)onProgressUpdate:(CDVInvokedUrlCommand*)command;

- (void)onPrescriptionTokens:(CDVInvokedUrlCommand*)command;

- (void)onPrescriptionBundles:(CDVInvokedUrlCommand*)command;

- (void)onError:(CDVInvokedUrlCommand*)command;

@end

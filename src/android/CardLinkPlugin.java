package org.apache.cordova.plugin;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import de.akquinet.health.service.cardlink.sdk.Cardlink;
import de.akquinet.health.service.cardlink.sdk.LogLevel;
import org.apache.cordova.plugin.ICardlinkCallbackObject;

/**
* This class echoes a string called from JavaScript.
*/
public class CardlinkPlugin extends CordovaPlugin {

    public static CallbackContext onStateChangedCallback;
    public static CallbackContext onProgressUpdateCallback;
    public static CallbackContext onPrescriptionTokensCallback;
    public static CallbackContext onPrescriptionBundlesCallback;
    public static CallbackContext onErrorCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("isNfcHardwareAvailable")) {
            this.isNfcHardwareAvailable(callbackContext);
            return true;
        } else if (action.equals("isNfcEnabled")) {
            this.isNfcEnabled(callbackContext);
            return true;
        } else if (action.equals("initialize")) {
            if  (args.getString(0) != null && args.getString(1) != null && args.getString(2) != null) {
                this.initialize(args.getString(0), callbackContext, args.getString(1), args.getString(2));
            } else {
                callbackContext.error("Enter url");
            }
            return true;
        } else if (action.equals("requestSmsToken")) {
            String phoneNumber = args.getString(0);
            String smsSenderId = args.getString(1);
            String smsTextTemplate = args.getString(2);
            String smsTextReassignmentTemplate = args.getString(3);

            if (phoneNumber != null && smsSenderId != null && smsTextTemplate != null && smsTextReassignmentTemplate != null) {
                this.requestSmsToken(phoneNumber, smsSenderId, smsTextTemplate, smsTextReassignmentTemplate, callbackContext);
            } else {
                callbackContext.error("Fill all the required fields.");
            }
            
            return true;
        } else if (action.equals("verifySmsToken")) {
            String smsToken = args.getString(0);

            if (smsToken != null) {
                this.verifySmsToken(smsToken, callbackContext);
            } else {
                callbackContext.error("Enter sms token");
            }
            
            return true;
        } else if (action.equals("startScan")) {
            String can = args.getString(0);

            if (can != null) {
                this.startScan(can, callbackContext);
            } else {
                callbackContext.error("Enter can");
            }
            
            return true;
        } else if (action.equals("stopScan")) {
            this.stopScan(callbackContext);
            return true;
        } else if (action.equals("shutdown")) {
            this.shutdown(callbackContext);
            return true;
        } else if (action.equals("onStateChanged")) {
            this.onStateChanged(callbackContext);
            return true;
        } else if (action.equals("onProgressUpdate")) {
            this.onProgressUpdate(callbackContext);
            return true;
        } else if (action.equals("onPrescriptionTokens")) {
            this.onPrescriptionTokens(callbackContext);
            return true;
        } else if (action.equals("onPrescriptionBundles")) {
            this.onPrescriptionBundles(callbackContext);
            return true;
        } else if (action.equals("onError")) {
            this.onError(callbackContext);
            return true;
        } else if (action.equals("setSmsEnabled")) {
            Boolean enabled = args.getBoolean(0);

            if (enabled != null) {
                this.setSmsEnabled(enabled, callbackContext);
            } else {
                callbackContext.error("Enter enabled parameter");
            }
            
            return true;
        } else if (action.equals("setDebug")) {
            Boolean enabled = args.getBoolean(0);

            if (enabled != null) {
                this.setDebug(enabled, callbackContext);
            } else {
                callbackContext.error("Enter enabled parameter");
            }

            return true;
        } else if (action.equals("setLogLevel")) {
            String logLevelString = args.getString(0);

            if (logLevelString != null) {
            LogLevel logLevel = LogLevel.valueOf(logLevelString);
                this.setLogLevel(logLevel, callbackContext);
            } else {
                callbackContext.error("Enter log level");
            }

            return true;
        }
        
        return false;
    }

    private void isNfcHardwareAvailable(CallbackContext callbackContext) {
        callbackContext.success(Cardlink.isNfcHardwareAvailable(this.cordova.getActivity()) ? 1 : 0);
    }

    private void isNfcEnabled(CallbackContext callbackContext) {
        callbackContext.success(Cardlink.isNfcEnabled(this.cordova.getActivity()) ? 1 : 0);
    }

    private void initialize(String url, CallbackContext callbackContext, String pkcs12Data, String password) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.initialize(url, new ICardlinkCallbackObject(), pkcs12Data, password);
                callbackContext.success("Initializing started, pkcs12Data: " + pkcs12Data + ", password: " + password);
            }
        });
    }

    private void requestSmsToken(String phoneNumber, String smsSenderId, String smsTextTemplate, String smsTextReassignmentTemplate, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.requestSmsToken(phoneNumber, smsSenderId, smsTextTemplate, smsTextReassignmentTemplate);
                callbackContext.success();
            }
        });
    }

    private void verifySmsToken(String smsToken, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.verifySmsToken(smsToken);
                callbackContext.success();
            }
        });
    }

    private void startScan(String can, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.startScan(can, CardlinkPlugin.this.cordova.getActivity());
                callbackContext.success();
            }
        });
    }

    private void stopScan(CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.stopScan();
                callbackContext.success();
            }
        });
    }

    private void shutdown(CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.shutdown();
                callbackContext.success();
            }
        });
    }

    private void onStateChanged(CallbackContext callbackContext) {
        CardlinkPlugin.onStateChangedCallback = callbackContext;
    }

    private void onProgressUpdate(CallbackContext callbackContext) {
        CardlinkPlugin.onProgressUpdateCallback = callbackContext;
    }

    private void onPrescriptionTokens(CallbackContext callbackContext) {
        CardlinkPlugin.onPrescriptionTokensCallback = callbackContext;
    }

    private void onPrescriptionBundles(CallbackContext callbackContext) {
        CardlinkPlugin.onPrescriptionBundlesCallback = callbackContext;
    }
    
    private void onError(CallbackContext callbackContext) {
        CardlinkPlugin.onErrorCallback = callbackContext;
    }

    private void setSmsEnabled(Boolean enabled, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.setSmsEnabled(enabled);
                callbackContext.success("setSmsEnabled enabled" + enabled);
            }
        });
    }

    private void setDebug(Boolean enabled, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.setDebug(enabled);
                callbackContext.success("setDebug enabled" + enabled);
            }
        });
    }

    private  void setLogLevel(LogLevel logLevel, CallbackContext callbackContext) {
        this.cordova.getThreadPool().execute(new Runnable() {
            public void run() {
                Cardlink.setLogLevel(logLevel);
                callbackContext.success("logLevel" + logLevel);
            }
        });
    }
}
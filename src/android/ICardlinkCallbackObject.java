package org.apache.cordova.plugin;

import de.akquinet.health.service.cardlink.sdk.ICardlinkCallback;
import de.akquinet.health.service.cardlink.sdk.CardlinkState;
import java.lang.String;
import java.util.List;
import de.akquinet.health.service.cardlink.sdk.CardlinkError;
import de.akquinet.health.service.cardlink.sdk.CardlinkAction;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONObject;
import org.json.JSONException;

class ICardlinkCallbackObject implements ICardlinkCallback {

    @Override
    public void onStateChanged(CardlinkState state) {
        if (CardlinkPlugin.onStateChangedCallback != null) {
            try {
                JSONObject resultObject = new JSONObject();
                resultObject.put("state", state.name());
                this.sendPluginResult(CardlinkPlugin.onStateChangedCallback, PluginResult.Status.OK, resultObject);
            } catch(JSONException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onProgressUpdate(int progress) {
        if (CardlinkPlugin.onProgressUpdateCallback != null) {
            try {
                JSONObject resultObject = new JSONObject();
                resultObject.put("progress", String.valueOf(progress));
                this.sendPluginResult(CardlinkPlugin.onProgressUpdateCallback, PluginResult.Status.OK, resultObject);
            } catch(JSONException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onPrescriptionTokens(String result) {
        if (CardlinkPlugin.onPrescriptionTokensCallback != null) {
            try {
                JSONObject resultObject = new JSONObject();
                resultObject.put("result", result);
                this.sendPluginResult(CardlinkPlugin.onPrescriptionTokensCallback, PluginResult.Status.OK, resultObject);
            } catch(JSONException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onPrescriptionBundles(List<String> bundles) {
        if (CardlinkPlugin.onPrescriptionBundlesCallback != null) {
            try {
                JSONObject resultObject = new JSONObject();
                
                for (int i = 0; i < bundles.size(); i++) {
                    resultObject.put(String.valueOf(i), bundles.get(i));
                }

                this.sendPluginResult(CardlinkPlugin.onPrescriptionBundlesCallback, PluginResult.Status.OK, resultObject);
            } catch(JSONException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onError(CardlinkError error, String message, CardlinkAction action) {
        if (CardlinkPlugin.onErrorCallback != null) {
            try {
                JSONObject resultObject = new JSONObject();
                resultObject.put("error", error);
                resultObject.put("message", message);
                resultObject.put("action", action);

                this.sendPluginResult(CardlinkPlugin.onErrorCallback, PluginResult.Status.OK, resultObject);
            } catch(JSONException e) {
                e.printStackTrace();
            }
        }
    }

    private void sendPluginResult(CallbackContext callbackContext, PluginResult.Status status, JSONObject resultObject) {
        PluginResult result = new PluginResult(status, resultObject);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }
}
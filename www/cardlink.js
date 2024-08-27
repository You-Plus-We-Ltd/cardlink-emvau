function Cardlink() {
    this.isNfcHardwareAvailable = function (callback, errorCallback) {
        if (device.platform == 'Android') {
            cordova.exec(callback, errorCallback, "CardlinkPlugin", "isNfcHardwareAvailable", []);
        }
    };
    
    this.isNfcEnabled = function (callback, errorCallback) {
        if (device.platform == 'Android') {
            cordova.exec(callback, errorCallback, "CardlinkPlugin", "isNfcEnabled", []);
        }
    };

    this.initialize = function (url, pkcs12Data, password) {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "initialize", [url, pkcs12Data, password]);
        });
    }

    this.requestSmsToken = function (phoneNumber, smsSenderId, msTextTemplate, smsTextReassignmentTemplate) {
        console.log("call requestSmsToken")
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "requestSmsToken", [phoneNumber, smsSenderId, msTextTemplate, smsTextReassignmentTemplate]);
        });
    }

    this.verifySmsToken = function (smsToken) {
        console.log("smsToken", smsToken)
        return new Promise((resolve, reject) => {
            console.log("inside promise")
            cordova.exec(resolve, reject, "CardlinkPlugin", "verifySmsToken", [smsToken]);
        });
    }

    this.startScan = function (can) {
        console.log("can", can);

        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "startScan", [can]);
        });
    }

    this.stopScan = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "stopScan", []);
        });
    }

    this.shutdown = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "shutdown", []);
        });
    }
    
    this.updateNfcMessage = function (message) {
        if (device.platform == 'iOS') {
            console.log("message", message);
            return new Promise((resolve, reject) => {
                cordova.exec(resolve, reject, "CardlinkPlugin", "updateNfcMessage", [message]);
            });
        }
    }

    this.onStateChanged = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "onStateChanged", []);
        });
    }

    this.onProgressUpdate = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "onProgressUpdate", []);
        });
    }

    this.onPrescriptionTokens = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "onPrescriptionTokens", []);
        });
    }

    this.onPrescriptionBundles = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "onPrescriptionBundles", []);
        });
    }

    this.onError = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "onError", []);
        });
    }

    this.setSmsEnabled = function (enabled) {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "setSmsEnabled", [enabled]);
        });
    }

    this.setDebug = function (enabled) {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "setDebug", [enabled]);
        });
    }

    this.setLogLevel = function (logLevel) {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "setLogLevel", [logLevel]);
        });
    }
}


module.exports = new Cardlink();

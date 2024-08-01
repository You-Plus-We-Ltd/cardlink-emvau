window.echo = function(str, callback) {
    cordova.exec(callback, function(err) {
        console.log("Error: " + err);
        callback(err);
    }, "CardlinkPlugin", "echo", [str]);
};

function Cardlink() {
    this.isNfcHardwareAvailable = function (callback, errorCallback) {
        cordova.exec(callback, errorCallback, "CardlinkPlugin", "isNfcHardwareAvailable", []);
    };
    
    this.isNfcEnabled = function (callback, errorCallback) {
        cordova.exec(callback, errorCallback, "CardlinkPlugin", "isNfcEnabled", []);
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

    this.shutdown = function () {
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "shutdown", []);
        });
    }
    
    this.updateNfcMessage = function (message) {
        console.log("message", message);
        return new Promise((resolve, reject) => {
            cordova.exec(resolve, reject, "CardlinkPlugin", "updateNfcMessage", [message]);
        });
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
}


module.exports = new Cardlink();

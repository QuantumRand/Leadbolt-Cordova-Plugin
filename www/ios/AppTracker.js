var AppTracker = {
        startSession : function(apikey, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "startSession", [apikey]);
        },
        closeSession : function(successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "closeSession", []);
        },
        event : function(name, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "event", [name]);
        },
        event : function(name, value, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "event", [name, value]);
        },
        transaction : function(name, value, currency, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "transaction", [name, value, currency]);
        },
        loadModule : function(location, userData, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "loadModule", [location, userData]);
        },
        loadModuleToCache : function(location, userData, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "loadModuleToCache", [location, userData]);
        },
        setCrashHandlerStatus : function(enable, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "setCrashHandlerStatus", [enable]);
        },
        fixAdOrientation : function(orientation, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "fixAdOrientation", [orientation]);
        },
        destroyModule : function(successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "destroyModule", []);
        },
        setAgeRange: function(ageRange, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "setAgeRange", [ageRange]);
        },
        setGender: function(gender, successcallback, errorcallback) {
            cordova.exec(successcallback, errorcallback, "AppTracker", "setGender", [gender]);
        } 
};

module.exports = AppTracker;
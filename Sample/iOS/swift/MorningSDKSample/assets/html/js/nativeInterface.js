class WebviewPacket {
    constructor() {
        this.methodName = 'methodName';
        this.arguments = 'arguments';
        this.callback = 'callback';
        this.resultCode = 'resultCode';
    }
}

function getInterface() {
    var interface = null;
    var varUA = navigator.userAgent.toLowerCase();
    console.log("getInterface : " + varUA);
    if ( varUA.indexOf('android') > -1) {
        console.log("getInterface Android");
        interface = window.HybridApp;
    } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
        interface = window.webkit.messageHandlers.HybridApp;
        console.log("getInterface Iphone");
    } else {
        interface = window.HybridApp;
        console.log("getInterface Uknown");
    }
    return interface;
}

function processNative(data){
    var interface = getInterface();
    if(interface != null) {
        interface.postMessage(btoa(data));
    }
}

function receiveBase64(data){
    var json = atob(data);
    if(json[0] == '\'' && json[json.length -1] == '\''){
        json = json.substring(1, json.length -1);
    }
    var protocol = JSON.parse(json);
    eval(protocol.callback)(json);
}

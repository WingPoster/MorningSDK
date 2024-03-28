//
//  WebAppInterface.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import Dispatch
import WebKit

class WebAppInterface {
    private var LOG_TAG = "WebAppInterface"
    private var lstPacket : Array<WebviewPacket> = Array()
    var mWebView : WKWebView!
    
    init(webview : WKWebView) {
        mWebView = webview
    }
    func processNative(packetstring: String?) {
        print(LOG_TAG + " " + "processNative : " + packetstring!)
        let webviewPacket = WebviewPacket(param: packetstring!)
        print(LOG_TAG + " " + "processNative : " + webviewPacket.toJSON())
        lstPacket.append(webviewPacket)
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(1)
        mainQueue.asyncAfter(deadline: deadline) {
            self.processPacket()
        }
    }
    private func processPacket() {
        if(lstPacket.count > 0) {
            let webviewPacket = lstPacket.removeLast()
            print(LOG_TAG + " " + "processPacket : " + webviewPacket.toJSON())
            MainApplication().sendMessage(webviewPacket : webviewPacket)
        }
        if(lstPacket.count > 0) {
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(1)
            mainQueue.asyncAfter(deadline: deadline) {
                self.processPacket()
            }
        }
    }
    func sendComplete(webviewPacket : WebviewPacket) {
        print(LOG_TAG + " " + "sendComplete : " + webviewPacket.toJSON())
        let arguments = webviewPacket.getArguments()
        let callback = webviewPacket.getCallback()
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(1)
        mainQueue.asyncAfter(deadline: deadline) {
            webviewPacket.setMethodName(strMethodName: callback)
            webviewPacket.setArguments(strArguments: arguments)
            webviewPacket.setCallback(strCallback: callback)
            webviewPacket.setResultCode(strResultCode: MainApplication().RESULT_SUCCESS)
            let javascriptString = "receiveBase64('" + webviewPacket.toBase64JSON() + "');"
            self.mWebView.evaluateJavaScript(javascriptString, completionHandler: {(result, error) in
                if let result = result {
                    print(result)
                }
            })
        }
    }
}

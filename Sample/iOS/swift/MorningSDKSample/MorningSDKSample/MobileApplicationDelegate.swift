//
//  MobileApplicationDelegate.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import UIKit

class MobileApplicationDelegate: UIResponder, UIApplicationDelegate {
    private var LOG_TAG = "MobileApplicationDelegate"
    var window: UIWindow?
    public var RESULT_SUCCESS: String
    public var RESULT_CANCEL: String
    public var RESULT_ERROR: String
    public var RESULT_HELP: String
    public var RESULT_FAILED: String

    private var mWebappInterface : WebAppInterface?
    override init() {
        RESULT_SUCCESS = "200"
        RESULT_CANCEL = "150"
        RESULT_ERROR = "151"
        RESULT_HELP = "152"
        RESULT_FAILED = "100"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    func receivePacket(packetstring : String?) {
        print(LOG_TAG + " " + "receivePacket : " + packetstring!)
        print(LOG_TAG + " " + "receivePacket : " + WebviewPacket(param : packetstring!).toJSON())
        mWebappInterface?.processNative(packetstring: packetstring!)
    }
    // Event handling when webpage fires
    func sendMessage(webviewPacket : WebviewPacket) {
        print(LOG_TAG + " " + "sendMessage : " + webviewPacket.toJSON())
        let mainView = UIApplication.shared.keyWindow?.rootViewController as! ViewController
        mainView.processRequest(webviewPacket: webviewPacket)
    }
    func sendComplete(webviewPacket : WebviewPacket) {
        print(LOG_TAG + " " + "sendComplete : " + webviewPacket.toJSON())
        mWebappInterface?.sendComplete(webviewPacket: webviewPacket)
    }
    func setWebAppInterface(webAppInterface : WebAppInterface) {
        print(LOG_TAG + " " + "setWebAppInterface!!")
        mWebappInterface = webAppInterface
    }
}


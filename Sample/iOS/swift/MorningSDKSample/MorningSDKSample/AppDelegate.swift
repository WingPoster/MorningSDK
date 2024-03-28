//
//  AppDelegate.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import UIKit

let mainApplication = UIApplication.shared.delegate as! MainApplicationDelegate

func MainApplication() -> MainApplicationDelegate {
    return mainApplication
}

@UIApplicationMain
class MainApplicationDelegate: MobileApplicationDelegate {
    private var LOG_TAG = "MainApplicationDelegate"
    private var mForgoundPushMode : Bool = false
    private var mAppName : String = ""
   
    override init() {
        super.init()
    }

    func getAppName() -> String {
        mAppName = (Bundle.main.infoDictionary!["CFBundleName"] as? String)!
        return mAppName
    }
}

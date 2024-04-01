//
//  WebviewPacket.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

class WebviewPacket {
    private var methodName : String = ""
    private var arguments : String = ""
    private var callback : String = ""
    private var resultCode : String = ""
    private var LOG_TAG : String = "WebviewPacket"
    
    init() {
        methodName = "null"
        arguments = "null"
        callback = "null"
        resultCode = "null"
    }
    init(param: String) {
        if(!param.isEmpty) {
            fromBase64JSON(json : param)
        }
    }
    init(dictObj: Dictionary<String, Any>) {
        fromDictionary(dictObj : dictObj)
    }
    func toBase64JSON() -> String {
        return toJSON().toBase64()
    }
    func toJSON() -> String {
        return "{\"methodName\":\"" + methodName + "\",\"arguments\":\"" + arguments + "\",\"callback\":\"" + callback + "\",\"resultCode\": \"" + resultCode + "\"}"
    }
    func toWebJSON() -> String {
        return "{methodName:" + methodName + ",arguments:" + arguments + ",callback:" + callback + ",resultCode: " + resultCode + "}"
    }
    func toDisplay() -> String {
        return "{\n\"methodName\":\"" + methodName + "\",\n\"arguments\":\"" + arguments + "\",\n\"callback\":\"" + callback + "\",\n\"resultCode\":\"" + resultCode + "\"\n}"
    }
    func fromBase64JSON(json: String) {
        let jsonText : String = json.fromBase64()!
        print(LOG_TAG + " " + jsonText)
        fromJSONString(json: jsonText)

    }
    func fromJSONString(json: String) {
        var dictObj : Dictionary<String, Any> = [String : Any]()
        do {
            dictObj = try JSONSerialization.jsonObject(with: Data(json.utf8), options: []) as! [String:Any]
            methodName = dictObj["methodName"] as! String
            arguments = dictObj["arguments"] as! String
            callback = dictObj["callback"] as! String
            resultCode = dictObj["resultCode"] as! String
        } catch {
            print(LOG_TAG + " " + error.localizedDescription)
        }
    }
    func fromDictionary(dictObj: Dictionary<String, Any>) {
        methodName = dictObj["methodName"] as! String
        arguments = dictObj["arguments"] as! String
        callback = dictObj["callback"] as! String
        resultCode = dictObj["resultCode"] as! String
    }
    func getMethodName() -> String {
        return methodName
    }
    func getArguments() -> String {
        return arguments
    }
    func getArgument(nIndex : Int) -> String {
        if(arguments.isEmpty) {
            return "NULL"
        }
        let strTemp = arguments.split(separator: ",")
        if(strTemp.count > nIndex) {
            return String(strTemp[nIndex])
        } else {
            return "NULL"
        }
    }
    func getCallback() -> String {
        return callback
    }
    func getResultCode() -> String {
        return resultCode
    }
    func setMethodName(strMethodName: String) {
        methodName = strMethodName
    }
    func setArguments(strArguments: String) {
        arguments = strArguments
    }
    func setCallback(strCallback: String) {
        callback = strCallback
    }
    func setResultCode(strResultCode: String) {
        resultCode = strResultCode
    }
}

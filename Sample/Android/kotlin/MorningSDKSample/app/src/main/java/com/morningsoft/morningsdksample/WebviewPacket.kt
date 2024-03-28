package com.morningsoft.morningsdksample

//
//  WebviewPacket.kt
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 18/07/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import android.util.Base64.*
import android.util.Log
import org.json.JSONException
import org.json.JSONObject

class WebviewPacket(param : String) {
    private var methodName = ""
    private var arguments = ""
    private var callback = ""
    private var resultCode = ""
    init {
        if(param.isNotEmpty()) {
            fromBase64JSON(param)
        }
    }
    fun toBase64JSON(): String {
        val json= "'{\"methodName\":\"$methodName\",\"arguments\": \"$arguments\",\"callback\": \"$callback\",\"resultCode\": \"$resultCode\"}'"
        return encodeToString(json.toByteArray(), NO_WRAP)
    }
    fun fromBase64JSON(json: String) {
        var jsonText = decode(json, NO_WRAP)
        fromJSON(jsonText.toString())
    }
    fun fromJSON(json: String) {
        try {
            val jObject = JSONObject(json)
            methodName = jObject.getString("methodName")
            arguments = jObject.getString("arguments")
            callback = jObject.getString("callback")
            resultCode = jObject.getString("resultCode")
        } catch (e: JSONException) {
            Log.d(LOG_TAG, "JSONObject Exception")
        }
    }
    fun getMethodName(): String {
        return methodName
    }
    fun getArguments(): String {
        return arguments
    }
    fun getCallback(): String {
        return callback
    }
    fun setMethodName(strMethodName: String) {
        methodName = strMethodName
    }
    fun setArguments(strArguments: String) {
        arguments = strArguments
    }
    fun setCallback(strCallback: String) {
        callback = strCallback
    }
    fun setResultCode(strResultCode: String) {
        resultCode = strResultCode
    }

    companion object {
        private const val LOG_TAG = "WebviewPacket"
    }
}

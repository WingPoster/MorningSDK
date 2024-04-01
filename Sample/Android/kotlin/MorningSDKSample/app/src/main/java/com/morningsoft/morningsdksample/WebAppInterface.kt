package com.morningsoft.morningsdksample

//
//  WebAppInterface.kt
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 18/07/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import android.annotation.SuppressLint
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.webkit.JavascriptInterface
import android.webkit.WebView

class WebAppInterface(webView : WebView?, var context: Context?){
    private var lstPacket : MutableList<WebviewPacket> =  mutableListOf()

    init {
        mWebView = webView
        mContext = context
    }

    @JavascriptInterface
    fun postMessage(data: String) {
        val webviewPacket = WebviewPacket(data)
        lstPacket.add(webviewPacket)
        Handler(Looper.getMainLooper()).postDelayed({
            processPacket()
        }, 1000)
    }
    private fun processPacket() {
        if(lstPacket.size > 0) {
            val webviewPacket = lstPacket.removeLast()
            MainApplication().sendMessage(webviewPacket)
        }
        if(lstPacket.size > 0) {
            Handler(Looper.getMainLooper()).postDelayed({
                processPacket()
            }, 1000)
        }
    }
    fun sendComplete(webviewPacket : WebviewPacket) {
        var methodName = webviewPacket.getMethodName()
        var arguments = webviewPacket.getArguments()
        val callback = webviewPacket.getCallback()
        Handler(Looper.getMainLooper()).postDelayed({
            webviewPacket.setMethodName(methodName)
            webviewPacket.setArguments(arguments)
            webviewPacket.setCallback(callback)
            webviewPacket.setResultCode(MainApplication().result_success)
            mWebView?.loadUrl("javascript:receiveBase64('" + webviewPacket.toBase64JSON() + "')")
        }, 3000)
    }

    @SuppressLint("StaticFieldLeak")
    companion object {
        private const val LOG_TAG = "WebAppInterface"
        private var mWebView: WebView? = null
        private var mContext: Context? = null
    }
}

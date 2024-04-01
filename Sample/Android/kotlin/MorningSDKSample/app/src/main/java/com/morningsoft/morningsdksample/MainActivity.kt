package com.morningsoft.morningsdksample

//
//  MainActivity.kt
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 18/07/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import android.annotation.SuppressLint
import android.app.Dialog
import android.os.*
import android.util.Log
import android.view.View
import android.webkit.*
import android.webkit.WebView.WebViewTransport
import android.content.Intent
import android.net.Uri
import android.webkit.WebView
import android.util.Base64
import androidx.appcompat.app.AlertDialog
import com.morningsoft.security.MorningSDK

import com.morningsoft.security.MorningSDKActivity
import org.webrtc.Logging

class MainActivity : MorningSDKActivity() {
    private var mWebView: WebView? = null
    private var mWebAppInterface: WebAppInterface? = null
    private var mWebSettings: WebSettings? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d(LOG_TAG, "onCreate Start")

        MorningSDK().setScreenProtectEnable(true)
        MorningSDK().setRootingCheckEnable(true)
        MorningSDK().setSignatureVerifyEnable(true)
        MorningSDK().setFridaProtectEnable(true)
        MorningSDK().setMagiskHideProtectEnable(true)
        MorningSDK().setTamperProtectEnable(true)

        if (BuildConfig.IS_DEV) {
            // This features are supported by the market.
            MorningSDK().setMarketVerifyEnable(false)
            MorningSDK().setDebuggableProtectEnable(false)
            MorningSDK().setDebuggerProtectEnable(false)
        } else {
            MorningSDK().setMarketVerifyEnable(true)
            MorningSDK().setDebuggableProtectEnable(true)
            MorningSDK().setDebuggerProtectEnable(true)
        }
        
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        processRequest()
        mWebView = findViewById<View?>(R.id.webview) as WebView?
        if (BuildConfig.IS_DEV) {
            WebView.setWebContentsDebuggingEnabled(true)
        }
        mWebSettings = mWebView?.settings
        mWebSettings?.javaScriptEnabled = true
        mWebSettings?.setSupportMultipleWindows(true)
        mWebSettings?.javaScriptCanOpenWindowsAutomatically = true
        mWebSettings?.useWideViewPort = false
        mWebSettings?.loadWithOverviewMode = true
        mWebSettings?.setSupportZoom(false)
        mWebSettings?.displayZoomControls = false
        mWebSettings?.cacheMode = WebSettings.LOAD_DEFAULT
        mWebSettings?.builtInZoomControls = false
        mWebSettings?.domStorageEnabled = true

        val interfaceName = MorningSDK().getObfuscation("IDS_INTERFACE_NAME")
        if (interfaceName != null) {
            mWebView?.addJavascriptInterface(WebAppInterface(mWebView, this), interfaceName)
        }
        mWebAppInterface = WebAppInterface(mWebView, this)
        mWebView?.addJavascriptInterface(mWebAppInterface!!, "HybridApp")
        mWebView?.clearCache(true)
        mWebView!!.post {
            mWebView!!.loadUrl(WEB_VIEW_LOAD_URL)
        }
        mWebView?.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                if (view != null) {
                    if (request != null) {
                              view.loadUrl(request.url.toString())
                    }
                }
                return true
            }
        }
        mWebView?.webChromeClient = object : WebChromeClient() {
            override fun onCreateWindow(view: WebView?, isDialog: Boolean, isUserGesture: Boolean, resultMsg: Message?): Boolean {
                Log.d(LOG_TAG, "onCreateWindow")
                val result = view!!.hitTestResult
                val data = result.extra
                if(data != null) {
                    val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse(data))
                    applicationContext.startActivity(browserIntent)
                    return false
                }

                val newWebView = view.let { WebView(it.context) }
                val webSettings = newWebView.settings
                webSettings.javaScriptEnabled = true
                val dialog = view.let { Dialog(it.context) }
                dialog.setContentView(newWebView)
                dialog.show()
                if (resultMsg != null) {
                    (resultMsg.obj as WebViewTransport).webView = newWebView
                }
                resultMsg?.sendToTarget()
                newWebView.webViewClient = object : WebViewClient() {
                    override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                        Log.d(LOG_TAG, "shouldOverrideUrlLoading")
                        if (request != null) {
                            if (request.url.toString().indexOf("upload") > -1) {
                                return true
                            }
                        }
                        if (view != null) {
                            if (request != null) {
                                view.loadUrl(request.url.toString())
                            }
                        }
                        return false
                    }
                    override fun onPageFinished(view: WebView?, url: String?) {
                        Log.d(LOG_TAG, "onPageFinished")

                    }
                }
                newWebView.webChromeClient = object : WebChromeClient() {
                    override fun onCloseWindow(window: WebView?) {
                        Log.d(LOG_TAG, "onCloseWindow")
                        dialog.dismiss()
                    }
                }
                return true
            }

            override fun onJsPrompt(view: WebView?, url: String?, message: String?, defaultValue: String?, result: JsPromptResult?): Boolean {
                Log.d(LOG_TAG, "onJsPrompt")
                AlertDialog.Builder(applicationContext)
                    .setTitle(applicationContext?.getString(R.string.app_name))
                    .setMessage(message)
                    .setPositiveButton(android.R.string.ok
                    ) { dialog, which -> result!!.confirm() }
                    .setNegativeButton(android.R.string.cancel
                    ) { dialog, which -> result!!.cancel() }
                    .setCancelable(false)
                    .create()
                    .show()
                return true
            }

            override fun onJsAlert(
                view: WebView?,
                url: String?,
                message: String?,
                result: JsResult,
            ): Boolean {
                AlertDialog.Builder(applicationContext)
                    .setTitle(applicationContext?.getString(R.string.app_name))
                    .setMessage(message)
                    .setPositiveButton(android.R.string.ok
                    ) { dialog, which -> result.confirm() }
                    .setCancelable(false)
                    .create()
                    .show()
                return true
            }

            override fun onConsoleMessage(consoleMessage: ConsoleMessage?): Boolean {
                if (consoleMessage != null) {
                    Log.d(LOG_TAG, "onConsoleMessage :: " + consoleMessage.message())
                }
                return true
            }
        }
        var result : String = MorningSDK().testMorningSDK()

        //Logging.enableLogToDebugOutput(Logging.Severity.LS_INFO)
        var webviewPacket = WebviewPacket("")
        webviewPacket.setMethodName("sendMessage")
        webviewPacket.setArguments(Base64.encodeToString(result.toByteArray(), Base64.NO_WRAP))
        webviewPacket.setCallback("receiveMessage")
        webviewPacket.setResultCode("200")
        runMessage(webviewPacket)
    }

    private fun processRequest() {
        val intent = intent
        if (Intent.ACTION_VIEW == intent.action) {
            val uri = intent.data
            if (uri != null) {
                val packet = uri.getQueryParameter("packet")
                val webviewPacket = packet?.let { WebviewPacket(it) }
                val methodName = webviewPacket?.getMethodName()
                when (methodName) {
                    "message" -> { runMessage(webviewPacket) }
                }
            }
        }
    }
    private fun runMessage(webviewPacket: WebviewPacket) {
        mWebAppInterface!!.sendComplete(webviewPacket)
    }
    companion object {
        private val LOG_TAG = MainActivity::class.java.simpleName
        private const val WEB_VIEW_LOAD_URL: String = BuildConfig.WEB_URL
    }
}

//
//  WebviewController.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import UIKit
import WebKit

class WebviewController: UIViewController, WKNavigationDelegate, UIPrintInteractionControllerDelegate {
    private var LOG_TAG = "WebviewController"
    
    @IBOutlet var mainView : UIView!
    @IBOutlet var webView : WKWebView!
    @IBOutlet var infoBtn : UIButton!
    var popupView : WKWebView?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var requestURL = "https://voip.morningjigsaw.com"
    var mWebAppInterface :WebAppInterface?
    override func loadView() {
        super.loadView()
        
        let contentController = webView.configuration.userContentController
        let config = WKWebViewConfiguration()

        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
        "head.appendChild(meta);"
        contentController.add(self, name: "MorningSDKSample")
        
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.webView.frame, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // iOS zoom disable
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
        
        print(LOG_TAG + " " + "loadView()")
        mWebAppInterface = WebAppInterface(webview : self.webView)
        MainApplication().setWebAppInterface(webAppInterface : mWebAppInterface!)
 
        self.mainView.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        self.webView.frame = self.view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "assets/html/sample", withExtension:"html")!
        webView.load(URLRequest(url: url))
     
        webView.allowsBackForwardNavigationGestures = true
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme != "https",url.scheme != "file" {
            UIApplication.shared.canOpenURL(url)
            decisionHandler(.cancel)
            print(LOG_TAG + "[WKNavigationDelegate] :: cancel => " + navigationAction.request.url!.absoluteString)
            return
        }

        decisionHandler(.allow)
        print(LOG_TAG + "[WKNavigationDelegate] :: allow => " +  navigationAction.request.url!.absoluteString)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(LOG_TAG + "[WKNavigationDelegate] :: didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(LOG_TAG + "[WKNavigationDelegate] :: didCommit")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(LOG_TAG + "[WKNavigationDelegate] :: didFail :: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(LOG_TAG + "[WKNavigationDelegate] :: didFinish")
    }
    
    func printInteractionControllerParentViewController(_ printInteractionController: UIPrintInteractionController) -> UIViewController? {
        return self
    }
}

extension WebviewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
}

extension URL {
    func queryValue(_ queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}

extension WebviewController : WKUIDelegate{
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            completionHandler(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let text = alert.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?{
        print(LOG_TAG + "[WKUIDelegate] :: createWebViewWith")
        if navigationAction.targetFrame?.isMainFrame == nil {
            webView.load(navigationAction.request)
        }
        
        popupView = WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
        popupView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupView?.uiDelegate = self
        
        view.addSubview(popupView!)
        
        return popupView
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        if webView == popupView {
            popupView?.removeFromSuperview()
            popupView = nil
        }
    }
}

extension WebviewController: WKScriptMessageHandler {
    // JS -> Native CALL
    @available(iOS 8.0, *)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        print(LOG_TAG + " [JS - Native IF] : \(message.name)")
        print(LOG_TAG + " didReceive : \(message.body)")
        
        let webviewPacket = WebviewPacket(param : message.body as! String)
        // Swift recognizes square brackets as parentheses.
        // This is just a difference in the way that JSON and traditional NeXT property lists represent arrays.
        // So, We must convert Dictionary to Json.
        //let webviewPacket = WebviewPacket(dictObj : message.body as! Dictionary<String, Any>)
        MainApplication().receivePacket(packetstring : webviewPacket.toBase64JSON())
    }
}

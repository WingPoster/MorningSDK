//
//  ViewController.swift
//  MorningSDKSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileShield
import WebRTC

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}

class ViewController: MobileShieldController{
    private var LOG_TAG = "ViewController"
    private var IS_DEV = true
    var obfuscation_data: String = "RDdUZGhZazNUVnFzbVR3SzdIZXdnMSswOURsWnlUY2NEWndvUnhmamYrNEUyMHYyaldTME9jeHJGZ1laWXVDSWhRazA5Q29hU1llT0hlcUp5Ni93R0JwRGYvRmJnWXU2QWcxa29zbzJXSDlpaDBpSlVlcUkxQWljbDVqY0poY0JIR2JFWWRER1AwTlRSSFhhUkF4bjRQSUdFbERYNE5jVE1WaHVmYjFTTGwwPV9FTkRfU3dqM1lNZmtDZ2hTK0pjeEtRTFBGM1Zsa0xvNGhHaHRaMHYrY1lKNEVjNmRGdVpvdUV4RlF0NGxWcUdiYmlTMFRBeXhrREY0M01LejdVamM4NFJlOGp3VkY5Si9lTTZZaXhlbTNaTWV1NE16eGVoNDRWTWpvODFUdzVDYWUwUlVQMUVvM1pOL0JFMXJkYTAwSTZWb3BpZGxNc282SkVRSFk4T0lsVXNJbVZVPV9FTkRfa1prY1QvRGVmM3NZT1Ziak9tZHlVQncwMmJPZ1pxVHB4YnUxcnlYRGZ4S3NWQkkxNWRHL2wvRnQ0OTZaMFloYVRHelNqckJhcVJNSTFTejdOcDVLcU1NN1AzUnpTNjRJdEtvWHkza05OenBvRThZL2s0SEc4c3ZrMGtTUlVYK1YrKzYzNXozK245a2JQaDBMUXlaNmJiWVlsZCtXVU9iWGtpTnJqRXM4L2ZZQS9hMm1veTFrYmVpTFFFRnYyZ3YzX0VORF8="
    var obfuscation_key_data:String = "TUlJQ2R3SUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NBbUV3Z2dKZEFnRUFBb0dCQUxDUVpBWklUYWFwTDgvMlpDK1QrT1N6NzJxVkpQY0dpcmNsT0JWNU5VSy9YTEtMaWlNNlo1ZS91UHozMUdjYXQxVisySDNMV0VtYjdGKzRtTnZMUUV5NWtmOElHcnFwVzlxMHdDOUNGcC9xMzF4NDViYWZ3YUZYMFJvNktpK0orWFUyMHBrY204SUhqcHJsZEN3NDdhMzBBZ1I0RjFpc1VXSFA2VzY3cUI4TEFnTUJBQUVDZ1lCd3NIZG1teGNVVzc4c1YvR3hmQnZLdkJ6K1JacUdIeUxCcVh1V0dQb3BVOEZ5SXlWVFBwK0hkdEkyZ21hS043N3pUallXYzRZeDFOYVVjVmorVDBjRm54MmZtVUlLOGcrdDZJZUJBSEY5MS8rcVZVMEt4SUd4MFA1RDdoYzdzeXY2VnNpMHhScTBGYWZyRVV5RFcvZjVMNjNGYTRJWnNiOWZoUU0rOXRaZ2dRSkJBUFFvS0pmMDg2OEtVOW1SYU11Yk1tbjRRbXNqTDN2a0t0UFRBTlpYalMwSUlBcWZmZDd4cFkwZzJkakxPYWNDRy94Q0NybFRxdG5JTWN1YmgwYzJ5UnNDUVFDNUlPUTZVK3hQbnBHL3dVOTF3Y1hTbGxrMW1EbFVUNEcySjNFNThNaThJS3VNeUtvek50aXdCS0NhdWhyV3NTYWs3N1VMQnJuRkthRXc2cWhPR05EUkFrRUFuTEdaTzh6TkI2Mk5HcmlqbE9oSmRwRUpyMUNwak0xbVh3T3dLZCtPanpRRHZFMlhycGxQTWorL0Q4OTlkSjE1OEc5Q0NxYVRvNmxEcS9SbzRWOWJ1UUpCQUliM1BzeHpVSzMvT2R6bHJ1dDMyS1Fkcm00UFM0UjI3bWNCUEYvMGRqUUpVV2d6QnpxTk9zNmdvUUlNdWZKWmRvWDZxQytndUtEUUo4OEUxSzBURkhFQ1FFbWlXbGlkRWlHYUdwNDYvVkM5ZE5LSURVa0cxTzRuN09XRWFzcW40TFJQUXlGR1FlYmEreGVDV08wRGdtY1B6ZkpueU9KSStiY3lyYWtqSnZzMll3Yz0="
    var license_data: String = "RUdhaHFhYmpwTVFiUml6RVoxSUI0MjV0emxzRXBBanBBbkhoaWN5NEV5bSt4d2RWM1JyWDhZd0JhT3ZDVTVHN051dGxoSzQ3OHR5WnZmMU1HVmJQMzk5NldYWnFySmJMYm02M0lHY0UvZGM0bjRSallBbWhqN3V2azFlcWRnYWU0TzRVNEwxalloQks5dk1MT0FZVFBuZmV6RUFpMWdtTTkwVWZhZ3BMTUl3PV9FTkRfRGIrWlNnVjJ0YUFHaVFzcFB0YmhLMUxoYTBrYTBjL2lHQjJ3ZXJZMUszd0ZmQmJBcjR2MHVRemFkck1tcG55RGQ2QXRWdDByUmMyYmhiQWlkRVpWU2lNc1BWZi9VbXpJU2hWcEdWZ24rcDVDWWdxcEswREdJbzVlMkNycnQ1Y29PaHdDZWZubk1vMDhnYnJxTi9MelNRbHVKblRsMmNIemdDbnJIMjZSS1g0PV9FTkRfeGRCSDFOeWdOS3RzMXU0QzcvNTZQL2pWOUgzK2NuRlo4RVVrNFJHSmV5bGoxSVNkbW5PeGFLZGo4TWdZdlRUL3BpbmxUT2oxbVVJSThDOHYwRks2dENrbHNPZkNHSFZjWGFwYWVRMWJNbk4yTGZhclF0Z0xwcEVZQ2xMbWw3emR1Q0V5cWI1enZzSFlCR1VJeUlDSkU3Nm1RQmVoWnhpZklRY2o5ZzRydGV5M3cxbEhwcmcrcC9GekEveFgzbVVNWlByVEZRdjBmTXVNNkthbHgzTWFFdnZrMTVJSGRLaHF5RGY3Z3dVSGExSEtZUlFMYWRDTVZQUjFWWWI1QnI1RG8wUGtDcktrSUR2VmUrcllhWERsd3NpOHNXaTMzR2lOcU5TSFNGL0VGdDltL09rMnBHVmhWaHdDbE15bURhQmpoTXZmL2xFeTZjQVNYUVVxdmxIbzlkektoNkdKNHk0RjY5OVZZR3ZNU0NIdEFGUWp4YVR0Y1lJemJXMDNWYjVlNVJ5RU0zT2R5b0dYcXl6ZnhleThuSlNaYk9DM01VSW1hZHZOTDRpUzRuU1BKaE9kRVlvd0tHWnNHdU5IeFpKWGFlbXROM0c4K3pNZkZIMTJNY2t3aU1zRVVnUHJZbGhxYU1aTWREL01iY3F0c3BaMlRwcDlib29zWnhnQzh4a0J0ZWM2SEwxVnNEMzZJVnEwNnlYVDBPQVEyNlpxWENMRHZ2dXJTVVRKVSs1RWp2MmV4cHpNMS91Y3h5YjVkdW5BcExDY3hIbnkwNWs5cUFudmFjNXkwMHh4RjZ4dnNDMTR5RThldmVqWDBSZFBUdDZmWU5hMTh4MVF0bmx4UmtBcHF1OU9aSThwT1FoQ3hjYkJaWm8xcFAra0FwUWlMWkpIVXhrNlY3Nmt5K3dPeVAwZmhpUzhtelhGdUFGUXMxVGFfRU5EXw=="
    var license_key_data:String = "TUlJQ2RRSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NBbDh3Z2dKYkFnRUFBb0dCQUpwc0ZSb0orUWxjbHAyZmVQbUZ5SGRZdDRkZmFDMi9CakVaQy9lbE4wN3RrQTBsSGM2bUNndmNpVkhIMnBkVkU1Q2hWZ0pjSklUT0VxWC95WWxOMkFsMmRSeTRkTTIzNXRIREhpWkdOZ21Sdm9IcUs0Ykh3VHVnMTdMN09KSURkdzc5VXJPNVp3WWVXSm5DalljUUJEKzRNK25iZkpIbkVLQzk4dnQ0VU9nMUFnTUJBQUVDZ1lCVHgzZmJYTFhFSW51RW9OU2RhN3ZMSkZMT0d6RUdRTEUzU2dONEpDYlJwNG1UMkNOSHprVjlFZlZlYlRObkR6MUNKb1huV2Q1bVB2ZFhJR05USHV5cHZjNi96cXNNVkZIcWFQSXhBdzhHVCsyN1pyajJkd0p2L0pIZnBNU29XVHI3ZmliQ2w4MXpLTWJkMFBCd0NrTm1DdnlMaUprODdac0JyQzEwa2EzRU1RSkJBTXZ3TTBRaE9LcHRFVUNLdWVobWhEaUdpL2F4eXM4VjY2bHZrdjNsUTdhSUYweG1ZemF5ekhacXlVYWY0RUc3dkFDRFB5L2VJQm5VUnBoWklwSFlnNzhDUVFEQjErYWZNRWYxNXIwdGNKY25XYW16Z1ZGNUdtMStGMmVXMjJFc1JFT3dUQXJ6TE1OQ09LZEh1VHlEVUVpR2JxU2VUSXArTWtNWTFkU2pPelRPWUlFTEFrQk1QNTk3VG94NE05VXFjM08wcjNlcUJxd1g3VHR0bDcySG1QNjFUTjIzUmtTbnZQUkZSQzVyNjlzYk83VkYvbUg1TXhrUjFaUGM5Ri84bi83cjFxN1RBa0FMVnhBYzIvdzV2SWZ3c3BlRks4K3J1ck1EZkxKUElCdGxUZXcvWkxiNUIxblVwQmZBTmdSRFErandYYkFBZlZTUUZqWTc3OERSSVNGUmMxTkJoNC9GQWtCNWlublVKZXAzZTY2VWxEK3drcFRMbkRLZnc3VmVHUk1QdXhKSVljajR1T1pzQ3F5T0NRMy85aFlUUDdQazRIRVhiR25tVk9KR25qUW5qVzdZMXQ2Ng=="
    override func viewDidLoad() {
        if(IS_DEV) {
            MobileShield.setLogLevel(logLevel : LogUtil.LEVEL_DEBUG)
        }
        MobileShield.setLicense(licenseData: license_key_data + "_END_" + license_data + "_END_" , configData: "voip.morningjigsaw.com\ncom.morningsoft.picturepuzzles\nmorningjigsaw.com\n1234567890987654321\n")
        MobileShield.setStringObfuscationEnable(enable: true)
        MobileShield.setObfuscation(obfuscationData: obfuscation_key_data + "_END_" + obfuscation_data + "_END_")
            
        MobileShield.setScreenProtectEnable(enable: true)
        MobileShield.setJailbrokenEnable(enable: true)
        MobileShield.setRunInEmulatorEnable(enable: true)
        if(IS_DEV) {
            MobileShield.setDebuggedEnable(enable: false)
            MobileShield.setTamperedEnable(enable: false)
        } else {
            MobileShield.setDebuggedEnable(enable: true)
            MobileShield.setTamperedEnable(enable: true)
        }
        MobileShield.setReverseEngineeredEnable(enable: true)
        MobileShield.setRuntimeHookedEnable(enable: true)
        MobileShield.setProxiedEnable(enable: true)
        MobileShield.setBreakpointAtEnable(enable: true)

        super.viewDidLoad()
        
        print(LOG_TAG + " " + "viewDidLoad end!!")
    }
    override func viewDidAppear(_ animated: Bool) {
        finishDeviceCheck()
    }
    
    func finishDeviceCheck() {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.showWebView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func processRequest(webviewPacket : WebviewPacket) {
        print(LOG_TAG + " " + "processRequest received!!")
        let methodName = webviewPacket.getMethodName()
        switch(methodName) {
            case "message" :
                runMessage(webviewPacket : webviewPacket)
                break;
            default :
                break;
        }
    }
    
    func runMessage(webviewPacket: WebviewPacket) {
        print(LOG_TAG + " " + "runMessage received!!")
        MainApplication().sendComplete(webviewPacket : webviewPacket)
    }

    func showWebView() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let webVc = storyboard.instantiateViewController(withIdentifier: "WebviewController") as! WebviewController
        self.present(webVc, animated: true, completion: nil)
        
        let message = MobileShield.testMobileShield()
        
        RTCSetMinDebugLogLevel(.info)
        
        var webviewPacket: WebviewPacket = WebviewPacket()
        webviewPacket.setMethodName(strMethodName: "sendMessage")
        webviewPacket.setArguments(strArguments: (message.toBase64()))
        webviewPacket.setCallback(strCallback: "receiveMessage")
        webviewPacket.setResultCode(strResultCode: "200")

        MainApplication().sendComplete(webviewPacket : webviewPacket)
        
        testURLRequest()
    }
    
    func testURLRequest(){
        // 1
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        // 2
        //var urlComponents = URLComponents(string: "https://www.google.com")
        var urlComponents = URLComponents(string: "http://morningsoft.com:8443")
        // 3
        let requestURL = urlComponents?.url
        // 4
        let dataTask = session.dataTask(with: requestURL!) { data, response, error in
            // 5
            guard error == nil else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                print("error http ---> \(error?.localizedDescription)")
                return
            }
            // 6
            guard let resultData = data else { return }
            let resultString = String(data: resultData, encoding: .utf8)
            print(resultString)
        }
        // 8
        dataTask.resume()
    }
}

extension ViewController: URLSessionDelegate{
    @nonobjc func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.host == "morningsoft.com" && challenge.protectionSpace.port == 8443 {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

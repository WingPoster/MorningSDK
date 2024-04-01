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
    var obfuscation_data: String = "ZldycGV2djlUbzIySWZtUnZhdnVJY3dNUGxrOS9oL1NNbVp0U0RMTytIMm9kYmhSRXN2ZDI4eEJCZ1IrbGhVMG0zQTY1a2VEa3dmY3hJM3Q2S1FhN3oramt4cjZQai96QWhHcDJCMlljbUVXK2phSElFeGF5TTBRcEVxcmZrUTJjUEdKV0J3R3VSOWVkSVYrWHBibE5hSkNvZXlrSlQrK1R1UEszZlI5YWxFPV9FTkRfRlhIVm1sU3oyNEFlaGxyQU5VMU84V05yN0FzT2JKK2JtQk1hdlg5ajgrL2xXTmQzeGJrZWlpcHMza3ViNG9zQ1EvVGdNdzNSMmFzcnpNUi81alhtUnJiSTJxa01nWFhvSXBaZG5oZlcyOFVJM2cyanUyeHJ5RUxTdnFIZURSQUtPaWZYNTJaWWovUDdHbVFiM0V3UmpoSGJESU43eXdGRlpyWlR4ZDh3YW1jPV9FTkRfcHE3OG1kVStpME9XVzFNV0pIK0lRNzM2R1NleG1FWWNKYWFiWVBpY3hwTnVSc01hSVIyWUVkeEpQQ0VsL2xxVE5GSklnSS9lOGxkSGFONk5mTnlNeTFRVHoydXJTeE1SMklRcDc5TUpla2ZHYXpzVmdpMGNwQjV1UVlTK2ZJek5TbWlIZE5lQ0xsVi9CY015aVZGbXU5c1lUVW96RksyS2RvNTB1MGtwTDVLcFlWazROd0JJT21qclZuckUvTkY4X0VORF8="
    var obfuscation_key_data:String = "TUlJQ2RnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NBbUF3Z2dKY0FnRUFBb0dCQUxNbkFTWnB2RU5nM3A0TzcvemxJWWIxaHdZamZ1SDZtQzZkSVdlWG5xaWVDVkNGYlNKdUtzYlRjQzNTZzN4N3Y0YjJYeU1DL3JMVXZKRFQwZUlxVjFKNmpicFJOaGJISlUvYy96QzAxbTRCT0Faem11Y2p5d1c2dWNJTFRLWDJ4bld3TE5LaGtwR0xsdGgraTZNZDFXNnM4czdjc25lQzZrU3ZXTllsZ3FCTkFnTUJBQUVDZ1lCNnJGNnhPdjNhOVYzNnhTZTM5LzM1Tis3NVdSenRDSGRrazl2bjMzNlkzMzVwVUxQbU82RzIrOWw0eHdtYUYvS1NLK29CUTIrOGJNZWlOQ2tud082Qk9uUWtvVXUwM3Jnb0Z5aXp1MVQwVU1EZ1Z5MTJyTU5MSmlra1ZValJzQ1lxa0cvd1drS1hiRG9HMHhoV1RYL0lWeVpSbXBpVWFmNnR1MTJISW9iUzBRSkJBTmhlakoxQzJCTnVzUlNQU1kzVUkxQ3N2akVQMXJseWlmNkV3dEQ2bkRvdnJaZWRndXJ0VHNiT3pLcW9HTGhPa25nLzhkaGhCTHNnaXZ3RHpzaXcybnNDUVFEVDkxNnZsd1gySjUrNDhGcXVrY0RWYjBjZVkzYXN5QnlTOHhzZTlGL05ZbG9xS1U3NGdXMGdYY2xDaWtvc3o2UDI2ZjBHb2hnblcxVFUxWFdlOVhuWEFrRUEwWjRvRkdNaCt4R09OU0RzWFo5YjUxaXptY3lDZG45aytWT2RlZUNSWWoyMnErQkphVmdtcmF6RDA4R3UwVUF0M3BuMHIzQ3VxS3ZLZW9VbDNJQ1o2UUpBRmd1RUxYN25mOUpmS2p6Vk1aSzNHM3VYU2ZIT1Jlb0tEcjU1ODU0MjJJV0NHeUJ3dGllLzBiM3ZVSnhSV3BlOTFkQkFJSkI3TXB5dEZmV2RaZ3Jod1FKQVd1ak9aY0ZFUy9Mb0w0WFR4Z0p3MVF0VFBwcUNNV3JrMGUwOCtGVzNtZDE0dkx1bmpMV0V6M3NNby9aVTV4dXdlWUp1TVg4NjkyYWJzd3Fsb202WVhnPT0="
    var license_data: String = "VkJnUWpFQUYvS2tvQmo5SUFSMjFwZEZnRDZpSmhHQ1RsdDNxdUdNTWJKMU5LVllyQWVsSG01c1ZuUFRUT0h2NkxXaXp0SU9XVmVNMkVMU003Ympybkg5UG9yaTRJVE1RMVZtbnZOYXlYL1pWYmI4MHM2YjFybHRQQXRrTExyc3pxTWQvbnJDdGxNL1ZBUnFQSUh6VVpRdVBtRUh5dU1lYndiQ0NWQlBwYUFNPV9FTkRfc253R05va0ljM0JydDR4Mkc2aHNNUVUvN0Q0YnI1MUZkNlNWSDdYalVESldScEx1MXQ5YUhTSzNkY0xXWk5vcWZrcG9YN1djRUFZeTdGbzVLSjNzdUY0T2F4ZFNENjZhUDh6MyttZG1ib1pGRjlVNjdEbUJFMUpzTGJobThNL0FFUnVaSUdDSHlSZGJPMVVnQVp6VE9Xc1BPbk42a3VZVUxaUUo4MlMwRmhRPV9FTkRfZzlrUW9FT2ltUHhKM3U4eWo5QVQrYlhEbUVxVmJvTWdrNmlxekRtN2lWNVN0YXFRS2NvZUlvdEFmYmx2azBTa1IwaFgrMVczSGo3K3NJSHlvRExJLzY3VHF5cFlWMVJLL0t3aWoweGtOOGZJOGk2VG5oSy8zYTFIM05PdjB0b1VXZE9FdC92a2pRT0x6L2dWamdJd3dPT2JYWXhPeXFwdnRRWnIyT3hDUmdPeE5CU0dreVhneWJYc0Q2dEcvQkZUSFFjTUlsTWg5YVpJS1hTRDFoTk8zbmpvaGhSZDkwaTRYREc2WGFaZURGR3VnWS9PWllkVytLbFFtcXdMcjJjeTI1TkJ4SXFZcHRFazJ6ZGN1dDUzNkUzalVVRElVZXdMQmhSVW1lajBLQkxIRTRPMXRxd1NDZUhNSkswaWw5VWZhWWpTNFZkczEwZE8zMmNqSGtNVGpZTFlIMjFnc2g5emo2QkdQYXExSXp0Q3p6MWUvL0VpTmNXQ1BHVlZ0c1NycHUxdXFiQlV2bHVTVC9ESlM3b2R6K3Q0SU5QUnJ5eE5MYmtxcXpDb2xSeE0vS2RZYk9rZ1lzUFg2UjRSYTVQNkI1SzlGMEdpaEZhVFkxaVU0QTNEbjJpWHVxMTlXYmJOUmV2UytKSHdsTXgvUTh1U2tMNDUzb3Q5dHB1RWdrZG5qYTlYRlhoYXE4ckYyUUhTY1FtaXVBTUxLRmIyTGdFRmdmNk56cUt4M1lMK25FSG9mMCtyV3FaOERLRmozSENuY1J5bXV3cTJaQ0xYTGcwQnl4cjQyUVpDc2dUYTUxU1VBQXBYNUZVaUU4VUJOZWZVYWR2SEx6UDh6dmhPWUpwTVFTMFhic2k2aEtOWmpiSy8yQzM1Y3BQWWVwdEtlMXpucXZtLzNxbUVBcWNBQ1FMdG93NTBOU1JjdkdNOWo0WWZfRU5EXw=="
    var license_key_data:String = "TUlJQ2RRSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NBbDh3Z2dKYkFnRUFBb0dCQUwzTGNCZ05ERTZGbnBSUjczRitCYWZGdStaOUdscjB2cFpIbS9IZmluWHpUa1YzVjdmblhOVC9VdVBjUFp2bzFaaUZDd0VrVDVNY01scGZaQkc5NmEzMWExYm4rRWMxUS92L09kajlhWlJxQWJPQkUxL1NVVjVWMG9hZXdHRjdJQ202elk2dDF6QVVMT2hkNjZXaHBJS1B6VFZQZ1RDdFFNQW03VzYxb29mTkFnTUJBQUVDZ1lCcjl5dDM4d3c2S3RhdjV3QS8zb0dYRSt1MHpSdk4vQVhpOVM5bjQxTWZqOTNKdEg4STFhdEFXMUlxM3VHSkxHVTlVd21VaDdSZ3FoeVd2a2J0dE13VnQ0V2tGQ0MxcmNsUGNZS2JSZWRacjh4ellqbVFJVERMV3dNSkRSeDR4bG5HU3BWUFVicEc5UHcyMDJLU2RGOXBXeTQ5S3p2VlYydVNseUt1cXZmZzNRSkJBTjg1bGtIdEl5eDJpVWxRSkV2b2hGNHNtZy8wN3RaU2J0QjI1N2oyRWZuWVNBY1BYejJKa3dzZ3FVeHhGRXJKa1VCVENuRVFsVThXSFIwakZ0YTdJdU1DUVFEWnFVeUJjN1BPc0d1eHFYdUE0RlFETVcyL1ZyRUV4Mm4vZVV4bU5ZQnBUaHk5ZWRJSG56OXJQQTNabTZjbUJRdHRkZGJJTmszWTNwTFhiengrekxtUEFrQUJZOEpqdHE0NVlLT0tLVTJRaTJvSGpBK0plZVRpd0xDZjY1MlZzVEo3YzdVL0ZnRnB5S2w1c0VKZGozYW80SWhlOWlWaWZzL3ZKaHdZU2xlaURwZ3hBa0JSVWN3d2pTNi9hUEJEWnlPcVNhVjVyK3psMEpqQVJWU1h5eFM5RnY0TDJkQXBCaXR2QjVNbEdFSEFiRVB0azNMcWlWMGVYaE9GazlwZXZNTm9TRXFIQWtCbERKMjJXNVBreDEyTGJUZkJTR3lXcUg0dFYzNlQ4K3RtZG5KSkphSHJaLzdBNUdoeDdqYUJ6SlRJbVNnQk5xcXhtWjcvUjgxZlQ5c3RjRnpaa0dVcw=="
    override func viewDidLoad() {
        if(IS_DEV) {
            MobileShield.setLogLevel(logLevel : LogUtil.LEVEL_DEBUG)
        }
        MobileShield.setLicense(licenseData: license_key_data + "_END_" + license_data + "_END_" , configData: "voip.morningsoft.com\ncom.morningsoft.morningsdksample\nmorningsoft.com\n1234567890987654321\n")
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
        var urlComponents = URLComponents(string: "https://api-project-73482779.web.app/")
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
        if challenge.protectionSpace.host == "api-project-73482779.web.app" && challenge.protectionSpace.port == 80 {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

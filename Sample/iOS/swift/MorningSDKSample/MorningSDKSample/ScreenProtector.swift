//
//  ScreenProtector.swift
//  PreventScreenshot
//
//  Created by Kyojun.Kim on 30/04/2022.
//  Copyright © 2022 Morningsoft. All rights reserved.
//
import UIKit

class ScreenProtector {
    private var warningWindow: UIWindow?
    
    func startPreventingRecording() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    func startPreventingScreenshot() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    @objc private func didDetectRecording() {
        DispatchQueue.main.async {
            CommonAlert.showAlertAction1(preferredStyle: .alert, title: "알림", message: "화면 녹화를 하실 수 없습니다.", completeTitle: "확인", self.exit)
        }
    }
    
    @objc private func didDetectScreenshot() {
        DispatchQueue.main.async {
            CommonAlert.showAlertAction1(preferredStyle: .alert, title: "알림", message: "화면 캡처를 하실 수 없습니다.", completeTitle: "확인", self.exit)
        }
    }
    
    func exit(){
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

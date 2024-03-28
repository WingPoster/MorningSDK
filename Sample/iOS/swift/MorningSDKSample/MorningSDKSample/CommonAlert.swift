//
//  CommonAlert.swift
//  MobileShieldSample
//
//  Created by Kyojun.Kim on 17/05/2023.
//  Copyright © 2023 Morningsoft. All rights reserved.
//

import UIKit

class CommonAlert {
    
    /**
     # showAlertAction1
     - Author:
     - Date:
     - Parameters:
        - vc: 알럿을 띄울 뷰컨트롤러
        - preferredStyle: 알럿 스타일
        - title: 알럿 타이틀명
        - message: 알럿 메시지
        - completeTitle: 확인 버튼명
        - completeHandler: 확인 버튼 클릭 시, 실행될 클로저
     - Returns:
     - Note: 버튼이 1개인 알럿을 띄우는 함수
    */
    static func showAlertAction1(preferredStyle: UIAlertController.Style = .alert, title: String = "", message: String = "", completeTitle: String = "확인", _ completeHandler:(() -> Void)? = nil){
        
        guard let currentVc = UIApplication.topViewController() else {
            completeHandler?()
            return
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                completeHandler?()
            }
            
            alert.addAction(completeAction)
            
            currentVc.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     # showAlertAction2
     - Author:
     - Date:
     - Parameters:
        - vc: 알럿을 띄울 뷰컨트롤러
        - preferredStyle: 알럿 스타일
        - title: 알럿 타이틀명
        - message: 알럿 메시지
        - cancelTitle: 취소 버튼명
        - completeTitle: 확인 버튼명
        - cancelHandler: 취소 버튼 클릭 시, 실행될 클로저
        - completeHandler: 확인 버튼 클릭 시, 실행될 클로저
     - Returns:
     - Note: 버튼이 2개인 알럿을 띄우는 함수
    */
    static func showAlertAction2(preferredStyle: UIAlertController.Style = .alert, title: String = "", message: String = "", cancelTitle: String = "취소", completeTitle: String = "확인",  _ cancelHandler: (() -> Void)? = nil, _ completeHandler: (() -> Void)? = nil){
        
        guard let currentVc = UIApplication.topViewController() else {
            completeHandler?()
            return
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancelHandler?()
            }
            let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                completeHandler?()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(completeAction)
            
            currentVc.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     # showAlertAction3
     - Author:
     - Date:
     - Parameters:
        - vc: 알럿을 띄울 뷰컨트롤러
        - preferredStyle: 알럿 스타일
        - title: 알럿 타이틀명
        - message: 알럿 메시지
        - cancelTitle: 취소 버튼명
        - completeTitle: 확인 버튼명
        - destructiveTitle: 삭제 버튼명
        - cancelHandler: 취소 버튼 클릭 시, 실행될 클로저
        - completeHandler: 확인 버튼 클릭 시, 실행될 클로저
        - destructiveHandler: 삭제 버튼 클릭 시, 실행될 클로저
     - Returns:
     - Note: 버튼이 3개인 알럿을 띄우는 함수
    */
    static func showAlertAction3(preferredStyle: UIAlertController.Style = .alert, title: String = "", message: String = "", cancelTitle: String = "취소", completeTitle: String = "확인", destructiveTitle: String = "삭제", _ cancelHandler:(() -> Void)? = nil, _ completeHandler:(() -> Void)? = nil, _ destructiveHandler:(() -> Void)? = nil){
        
        guard let currentVc = UIApplication.topViewController() else {
            completeHandler?()
            return
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancelHandler?()
            }
            let destructiveAction = UIAlertAction(title: destructiveTitle, style: .destructive) { action in
                cancelHandler?()
            }
            let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                completeHandler?()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(destructiveAction)
            alert.addAction(completeAction)
            
            currentVc.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}



//
//  LocalAuthHandler.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

struct LocalAuthHandler {
    static let shared = LocalAuthHandler()
    
    private func authErrorAlert(with message: String?) {
        let errorMessage = message ?? "Authendication error happen"
        
        let alertViewController = UIAlertController.init(title: "Auth Error", message: errorMessage, preferredStyle: .alert)
        let quiteAction = UIAlertAction.init(title: "Exit this application", style: .destructive) { (_) in
            exit(0)
        }
        alertViewController.addAction(quiteAction)
        
        getTopViewController().present(alertViewController, animated: true, completion: .none)
    }
    
    private func getTopViewController() -> UIViewController {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            return rootViewController.topViewController()
        }
        return UIViewController()
    }
    
    func authenticationWithTouchID() {
        return
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    let errorMessage = self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)
                    print(errorMessage)
                    self.authErrorAlert(with: errorMessage)
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            let errorMessage = self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code)
            print(errorMessage)
            authErrorAlert(with: errorMessage)
        }
    }
    
    private func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    private func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}

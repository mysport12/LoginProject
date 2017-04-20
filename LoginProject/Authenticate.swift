//
//  Authenticate.swift
//  LoginProject
//
//  Created by Craig Martin on 4/28/15.
//  Copyright (c) 2015 MadKitty. All rights reserved.
//

import UIKit
import LocalAuthentication

@objc(Authenticate)
class Authenticate: LAContext {
    
    class func authenticateUser() {
        var context:LAContext = LAContext()
        var error: NSError?
        let myLocalizedReasonText: String = ""
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonText, reply: { (success: Bool, evalPolicyError:NSError?) -> Void in
            if success {
            
            } else {
                println(evalPolicyError?.localizedDescription)
                
                switch evalPolicyError!.code {
                case LAError.SystemCancel.rawValue:
                        println("Authentication was canceled by the system")
                case LAError.UserCancel.rawValue:
                        println("Authentication was canceled by the user")
                case LAError.UserFallback.rawValue:
                        println("User decided to enter in custom password")
                default: println("Authentication failed")
                }
                }
            })]
        } else {
            
            switch error!.code {
                
            case LAError.TouchIDNotEnrolled.rawValue:
                println("TouchID not enrolled on this device")
            case LAError.PasscodeNotSet.rawValue:
                println("Passcode has not been set")
            default: println("TouchID not available on this device")
                
            }
        }
    }

}

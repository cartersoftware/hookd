//
//  UserManager.swift
//  BerkshireBuzz
//
//  Created by Vladimir Bahtjak on 11/10/17.
//  Copyright © 2017 BerkshireBuzz. All rights reserved.
//

import UIKit
import CDAlertView

class AlertManager: NSObject {
    
    class var sharedManager : AlertManager {
        struct _Singleton{
            static let instance = AlertManager()
        }
        return _Singleton.instance
    }
    
    func showError(title:String, subTitle:String, buttonTitle:String) {
        let alert                  = CDAlertView(title: title, message: subTitle, type: .error)
        alert.circleFillColor      = HOOKDRED
        let doneAction             = CDAlertViewAction(title: buttonTitle)
        doneAction.buttonTextColor = UIColor.black
        
        alert.add(action: doneAction)
        alert.show()
    }
}



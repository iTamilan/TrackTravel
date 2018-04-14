//
//  UIAlertViewController+Custom.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 Itamilan. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitile title:String?, message:String?, cancelTitle: String?, titleList:[String] = ["Dismiss"], handler: ((String,Int) -> Swift.Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var buttonTitleList = titleList
        if let cancelButtonTitle = cancelTitle {
            buttonTitleList.insert(cancelButtonTitle, at: 0)
        }
        let buttonTitleCount:Int = buttonTitleList.count
        for index in 0..<buttonTitleCount {
            var actionStyle = UIAlertActionStyle.default
            
            if index==0, cancelTitle != .none {
                actionStyle = .cancel
            }
            var buttonTitle = buttonTitleList[index]
            if buttonTitle.count == 0 {
                buttonTitle = "Dismiss"
            }
            alert.addAction(UIAlertAction(title:buttonTitle , style: actionStyle, handler: { (alertAction) in
                DispatchQueue.main.async {
                    if let handlerThere = handler {
                        handlerThere(buttonTitle,index)
                    }
                }
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
}

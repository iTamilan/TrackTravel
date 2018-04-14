//
//  UIViewController+PresentedViewController.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 Itamilan. All rights reserved.
//

import UIKit

extension UIViewController {
    func topViewController() -> UIViewController {
        if let topViewController = presentedViewController {
            return topViewController.topViewController()
        } else {
            return self
        }
    }
}

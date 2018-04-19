//
//  UIView+Autolayout.swift
//  TrackMe
//
//  Created by Tamilarasu on 15/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import UIKit

struct ViewSides: OptionSet {
    let rawValue: Int
    static let top = ViewSides(rawValue: 1 << 0)
    static let right = ViewSides(rawValue: 1 << 1)
    static let bottom = ViewSides(rawValue: 1 << 2)
    static let left = ViewSides(rawValue: 1 << 3)
    static let leading = ViewSides(rawValue: 1 << 4)
    static let trailing = ViewSides(rawValue: 1 << 5)
}

extension UIView {
    
    func addConstraintsPinningAllSidesToSuperview() {
        addConstraintsPinningAllSidesToSuperview(constant: 0)
    }
    
    func addConstraintsPinningAllSidesToSuperview(constant: CGFloat) {
        addConstraintsPinningSidesToSuperview([.top, .right, .bottom, .left],
                                              constant: constant)
    }
    
    func addConstraintsPinningSidesToSuperview(_ sides: ViewSides,
                                               constant: CGFloat = 0)
    {
        guard let superview = self.superview else {
            print("No superview to constrain to")
            return
        }
        
        if sides.contains(.top) {
            addConstraintToView(superview, withAttribute: .top, constant: constant)
        }
        
        if sides.contains(.right) {
            addConstraintToView(superview, withAttribute: .right, constant: -constant)
        }
        
        if sides.contains(.bottom) {
            addConstraintToView(superview, withAttribute: .bottom, constant: -constant)
        }
        
        if sides.contains(.left) {
            addConstraintToView(superview, withAttribute: .left, constant: constant)
        }
        
        if sides.contains(.leading) {
            addConstraintToView(superview, withAttribute: .leading, constant: constant)
        }
        
        if sides.contains(.trailing) {
            addConstraintToView(superview, withAttribute: .trailing, constant: -constant)
        }
    }
    
    private func addConstraintToView(_ view: UIView,
                                     withAttribute attribute: NSLayoutAttribute,
                                     constant: CGFloat)
    {
        let constraint = equalityConstraintWithLayoutAttribute(attribute, constant: constant)
        view.addConstraint(constraint)
    }
    
    private func equalityConstraintWithLayoutAttribute(_ attribute: NSLayoutAttribute,
                                                       constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: attribute,
                                  multiplier: 1,
                                  constant: constant)
    }
}

extension UIView {
    func addSubviewForConstraints(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    func addSubviewsForConstraints(_ subviews: [UIView]) {
        subviews.forEach(addSubviewForConstraints(_:))
    }
}

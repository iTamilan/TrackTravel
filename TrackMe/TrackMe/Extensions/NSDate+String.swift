//
//  NSDate+String.swift
//  TrackMe
//
//  Created by Tamilarasu on 15/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation

let dateFormat = "dd MMM yyyy hh:mm:ss"
let dateFormatter = DateFormatter()
extension Date {
    func formattedString() -> String? {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

//
//  UITableViewCell+Extensions.swift
//  App
//
//  Created by Jason Susanto on 22/08/24.
//

import UIKit

extension UITableViewCell {

    /// Returns the cell identifier based on the class name.
    public static var cellIdentifier: String {
        return String(describing: self)
    }

    /// Returns the nib name based on the class name.
    public static func nibName() -> String {
        return cellIdentifier + "XIB"
    }
}

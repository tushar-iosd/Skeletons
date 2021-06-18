//
//  UIViewExtension.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 02/06/21.
//

import UIKit
extension UIView {
    
    /// Circularises the View
    /// - Parameter enable: Circular or normal view toggled with enable
    func circle(enable: Bool = true) {
        self.layoutIfNeeded()
        let cornerRadius = min(bounds.width, bounds.height) / CGFloat(2)
        layer.cornerRadius = enable ? cornerRadius : CGFloat(0)
        layer.masksToBounds = enable
    }
}

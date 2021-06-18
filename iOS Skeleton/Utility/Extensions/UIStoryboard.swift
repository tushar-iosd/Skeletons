//
//  UIStoryboard.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 17/06/21.
//

import UIKit

extension UIStoryboard {
    //MARK:-  Generic Method
    /// To get ViewController
    /// - Returns: T of type UIViewController
    func instantiateViewController<T:UIViewController>() -> T? {
        let className = String(describing: T.self)
        return self.instantiateViewController(withIdentifier: className) as? T
    }
}

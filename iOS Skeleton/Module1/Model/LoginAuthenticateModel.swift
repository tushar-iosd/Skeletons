//
//  LoginModel.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 02/06/21.
//

import UIKit

protocol  LoginAuthenticateModel {
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
}

class DefraAuthenticateModel: LoginAuthenticateModel {
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->()) {
        
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            var error: NSError? = nil
            if email != "e" || password != "p" {
                error = NSError(domain: "iOS - Skeleton",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
            }
            completionHandler(error)
        }
    }
}

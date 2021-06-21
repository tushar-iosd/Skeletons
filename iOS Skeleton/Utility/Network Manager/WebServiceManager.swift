//
//  WebServiceManager.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 03/06/21.
//

import UIKit
class WebServiceManager {
   
    private init(){}
    // MARK:  Property
    static let shared = WebServiceManager()
    func callRandomListApi(for parameters: JSONDictionary, successClosure: @escaping booleanClosure,
                      failureClosure: @escaping apiCallFailureClosure) {
        NetworkManager.shared.startRequest(NetworkRouter.RandomList(parameters)) { (success, data, error) in
            if success {
                print("Data Received Succesfully", data as Any)
            } else {
                if let localError = error {
                    debugPrint(localError)
                    failureClosure(localError)
                }
            }
        }
    }
}

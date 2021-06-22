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
                
                guard let responseData = data, data?.count ?? 0 > 0, data != nil, data != nil else {
                    debugPrint("Can't process with the response")
                    return
                }
                print("Can process the data")
                do {
                    let data = try JSONDecoder().decode(Array<Comments>.self, from: responseData)
                    print(data)
                
                } catch let error {
                    debugPrint(error)
                }
                
            } else {
                if let localError = error {
                    debugPrint(localError)
                    failureClosure(localError)
                }
            }
        }
    }
}

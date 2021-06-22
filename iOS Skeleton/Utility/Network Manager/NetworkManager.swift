//
//  NetworkManager.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 03/06/21.
//

import UIKit
import Alamofire
class NetworkManager {
    // MARK:  Private Initializer
    private init() {}
    
    static let shared = NetworkManager()
    
    func startRequest(_ requestConvertible: URLRequestConvertible,
                      with completionHandler: @escaping completionClosure) {

        AF.request(requestConvertible).responseJSON { (APIResponse) -> Void in
            self.handleResponse(apiResponse: APIResponse, completionBlock: { (success, data, error) -> () in
                print(APIResponse)
                completionHandler(success, data,error)
            })
        }
    }
    
    func handleResponse(apiResponse: DataResponse<Any,AFError>, completionBlock: @escaping completionClosure) {
        if apiResponse.error == nil {
            print("Succesfull Data ")
            if let data = apiResponse.data {
                completionBlock(true,data,nil)
            } else {
                completionBlock(true,nil, noDataError)
            }
        } else {
            completionBlock(false, nil, apiResponse.error as NSError?)
            print("Error Data ")
        }
    }
  

}

//
//  NetworkRouter.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 03/06/21.
//

import UIKit
import Alamofire

enum NetworkRouter : URLRequestConvertible {
    
    case RandomList(JSONDictionary)
    var method: HTTPMethod {
        switch self {
        case .RandomList:
            return .get
        }
    }
    
    var relativeURL: String {
        switch self {
        case .RandomList:
            return "http://worldtimeapi.org/api/timezone/America/Argentina/Salta"
        }
    }
    
    var params: JSONDictionary?  {
        switch self  {
        case .RandomList(let randomListParam):
            return randomListParam
        }
    }
    func asURLRequest() throws -> URLRequest {
        let urlString: String = Constants.RelativeURLPath.serverURL + relativeURL
        let completeURL = URL.init(string: urlString)
        var urlRequest = URLRequest(url: completeURL!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = TimeInterval(90)
        
        let encoding: ParameterEncoding = URLEncoding.default //try JSONEncoding instead of URLEncoding if doesn't work
        return try! encoding.encode(urlRequest, with: params)
        }
    }

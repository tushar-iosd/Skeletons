//
//  RxRequestResponseManager.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 22/06/21.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
struct Constant {
    
    //The API's base URL
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let userId = "userId"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}


//APIRouter

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    case getPosts(userId: Int)
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constant.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constant.ContentType.json.rawValue, forHTTPHeaderField: Constant.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constant.ContentType.json.rawValue, forHTTPHeaderField: Constant.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getPosts:
            return "posts"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .getPosts(let userId):
            //A dictionary of the key (From the constants file) and its value is returned
            return [Constant.Parameters.userId : userId]
        }
    }
}
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}


class ApiClient {
    
    static func getPosts(userId: Int) -> Observable<[Post]> {
        return request(ApiRouter.getPosts(userId: userId))
    }
    
    //-------------------------------------------------------------------------------------------------
    //MARK: - The request function to get results in an Observable
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
       
            let request = AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                //Check the result from Alamofire's response and check if it's a success or a failure
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

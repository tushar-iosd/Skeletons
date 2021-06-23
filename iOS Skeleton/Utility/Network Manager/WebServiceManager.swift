//
//  WebServiceManager.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 03/06/21.
//

import UIKit
import RxSwift
import RxCocoa
class WebServiceManager {
    
    //Dispose Bag
    let disposeBag = DisposeBag()
    
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
                   
                  let new =  Observable<Data>.just(responseData).map(Array<Comments>.self)
                
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
    
    func fetchDataFromAPI(fromRx: Bool = false){
        ApiClient.getPosts(userId: 1)
            .observe(on:MainScheduler.instance)
            .subscribe(onNext: { [weak self] postsList in
                        print("List of posts:", postsList)
                    }, onError: { error in
                        switch error {
                        case ApiError.conflict:
                            print("Conflict error")
                        case ApiError.forbidden:
                            print("Forbidden error")
                        case ApiError.notFound:
                            print("Not found error")
                        default:
                            print("Unknown error:", error)
                        }
                    })
                    .disposed(by: disposeBag)
            }
}



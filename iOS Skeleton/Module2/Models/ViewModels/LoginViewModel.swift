//
//  LoginViewModel.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit
import RxSwift
import RxCocoa
class LoginViewModel {
    // Publish Objects when any textfield bind with it will have any change
    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    /// Combining both input of userName and password textPublishSubject and match the condition
    /// - Returns: Observable Boolean value
    func isValid() -> Observable<Bool>{
        return Observable.combineLatest(userNameTextPublishSubject.asObservable().startWith(""), passwordTextPublishSubject.asObservable().startWith("")).map { userName, password  in
        return userName.count > 4 && password.count > 4
        }
    }
}

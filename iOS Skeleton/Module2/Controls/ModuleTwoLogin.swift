//
//  LoginViewController.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit
import RxSwift
import RxCocoa
class ModuleTwoLogin: UIViewController {

    private let loginVM = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var userNameTF: 
        override func viewDidLoad() {
            super.viewDidLoad()
            setBinding()
            // Do any additional setup after loading the view.
            
        }
        
        func setBinding(){
            userNameTF.rx.text.maUITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    p { $0 ?? "" }.bind(to: loginVM.userNameTextPublishSubject).disposed(by: disposeBag)
        passTF.rx.text.map { $0 ?? "" }.bind(to: loginVM.passwordTextPublishSubject).disposed(by: disposeBag)
        loginVM.isValid().bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        loginVM.isValid().map{$0 ? 1 : 0.1}.bind(to: loginBtn.rx.alpha).disposed(by: disposeBag)
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        if let listViewObj: RxListViewController = Constants.StoryboardName.secondModuleStoryboard.instantiateViewController() {
           self.navigationController?.pushViewController(listViewObj, animated: true)
        }
    }

}

class LoginViewModel {
    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool>{
        return Observable.combineLatest(userNameTextPublishSubject.asObservable().startWith(""), passwordTextPublishSubject.asObservable().startWith("")).map { userName, password  in
        return userName.count > 3 && password.count > 4
        }
        
    }
}

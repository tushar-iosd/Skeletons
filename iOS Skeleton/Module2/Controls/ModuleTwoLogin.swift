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

    // View model of Login functionality
    private let loginVM = LoginViewModel()
    //Dispose Bag to manage memory management provided by RxSwift
    private let disposeBag = DisposeBag()
    
    /* IB Outlets */
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    /* View Life cycle methods*/
        override func viewDidLoad() {
            super.viewDidLoad()
            //Navigation Bar title
            self.navigationItem.title = "Login"
            //Binding of data with IBOutlets
            setBinding()
        }
    
    /// setBinding method will bind data between IBOutlets and user entered inputs
    func setBinding(){
      //  username and password text field's every text entry bind to
            userNameTF.rx.text.map{ $0 ?? "" }.bind(to: loginVM.userNameTextPublishSubject).disposed(by: disposeBag)
        
        passTF.rx.text.map { $0 ?? "" }.bind(to: loginVM.passwordTextPublishSubject).disposed(by: disposeBag)
        
        
        //isValid method of Login View model is to check if botf TF's count is greater than 4 or not and according to that login button will be enable or not
        loginVM.isValid().bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        loginVM.isValid().map{$0 ? 1 : 0.1}.bind(to: loginBtn.rx.alpha).disposed(by: disposeBag)
    }
    
    /// Login button action
    /// - Parameter sender: UIButton type
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if let listViewObj: RxListViewController = Constants.StoryboardName.secondModuleStoryboard.instantiateViewController() {
           self.navigationController?.pushViewController(listViewObj, animated: true)
        }
    }

}

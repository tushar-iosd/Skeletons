//
//  LoginViewController.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 02/06/21.
//

import UIKit
class LoginViewController: UIViewController {
    
    static var count: Int = 1
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel: LoginAuthenticationProtocol? {
        willSet {
         viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Initialise the view model
        // Do any additional setup after loading the view.
        emailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.viewModel = LoginAuthViewModel(controller: self)
        self.viewModel?.model = DefraAuthenticateModel()
        loginBtn.circle()
        refreshDisplay()
        
    }

    fileprivate func refreshDisplay() {
        if let viewModel = viewModel {
            self.loginBtn.backgroundColor = .yellow
            emailTF.placeholder = viewModel.placeholder
            emailTF.text = viewModel.email
            passTF.text = viewModel.password
        }
    }
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if let dashboardObj: DashboardViewController = Constants.StoryboardName.main.instantiateViewController() {
           self.navigationController?.pushViewController(dashboardObj, animated: true)
        }
       //randomApiCall()
        //viewModel?.submit()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTF {
            if let text = textField.text {
                viewModel?.email = text
            }
        }
        if textField == passTF {
            if let text = textField.text {
                viewModel?.password = text
            }
        }
    }
    
    func randomApiCall(){
        WebServiceManager.shared.callRandomListApi( for: [:], successClosure: { (isSuccess) in
            
            if isSuccess {
                print("success here")
            }
        }) { (_) in
            
        }
        
    }
}


/// AuthenticateViewModelViewDelegate Implementation
extension LoginViewController: AuthenticateViewModelViewDelegate {
    func canSubmitStatusDidChange(_ viewModel: LoginAuthViewModel, status: Bool) {
        print("canSubmitStatusDidChange VC", viewModel.errorMessage)
    }
    
    func errorMessageDidChange(_ viewModel: LoginAuthViewModel, message: String) {
        print("errorMessageDidChange VC")
    }
    
    
}

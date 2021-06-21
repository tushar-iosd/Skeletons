//
//  LoginViewModel.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 02/06/21.
//

import UIKit
class LoginAuthViewModel: LoginAuthenticationProtocol {
    
    var model: LoginAuthenticateModel?
    weak var controller: LoginViewController?
   init(controller: LoginViewController) {
        self.controller = controller
    }
    weak var viewDelegate: AuthenticateViewModelViewDelegate?
    var placeholder: String = "Login" {
        didSet {
        }
    }
    
    var email: String = "" {
        didSet {
            
        }
    }
    
    var password: String = "" {
        didSet {
            
        }
    }
    
    
    var canSubmit: Bool {
        return false
    }
    
    func submit() {
        errorMessage = ""
        guard let dataModel = model else {
            print("sddsdsdsdsd")
            errorMessage = NSLocalizedString("NOT_READY_TO_SUBMIT", comment: "")
            return
        }
        
        _ = { (error: NSError?) in
            //Make sure we are on the main thread
            DispatchQueue.main.async {
                guard let error = error else {
                
                    return
                }
                self.errorMessage = error.localizedDescription
            }
        }
        dataModel.login(email: email, password: password) { (modelCompletionHandler) in
            
            if modelCompletionHandler?.code != 1 {
                DispatchQueue.main.async {
                    self.controller?.view.backgroundColor = .green
                    self.viewDelegate?.canSubmitStatusDidChange(self, status: true)
                  
                }
                
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "can't"
                    self.viewDelegate?.canSubmitStatusDidChange(self, status: false)
                    self.controller?.view.backgroundColor = .red
                }
            }
        }
    }
    
    var errorMessage: String = "" {
        didSet {
            
        }
    }
    

    
}

protocol AuthenticateViewModelViewDelegate: class
{
    func canSubmitStatusDidChange(_ viewModel: LoginAuthViewModel, status: Bool)
    func errorMessageDidChange(_ viewModel: LoginAuthViewModel, message: String)
}

protocol LoginAuthenticationProtocol {
 
    var model: LoginAuthenticateModel? { get set }
    var viewDelegate: AuthenticateViewModelViewDelegate? { get set }
    
    // Email and Password
    var email: String {get set}
    var password: String {get set}
    
    var placeholder: String {get set}
    // Submit
    var canSubmit: Bool { get }
    func submit()
    
    // Errors
    var errorMessage: String { get }
}


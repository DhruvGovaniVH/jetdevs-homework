//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

class LoginViewModel {

    private var onLoginSuccess: (() -> Void)?
    private var onShowError: ((String) -> Void)?
    var loggedInUser: User?
    private lazy var repo = { LoginRepo() }()
    
    init(onLogin: (() -> Void)?, onShowError: ((String) -> Void)?) {
        
        self.onLoginSuccess = onLogin
        self.onShowError = onShowError
        
    }
    
    /// Will invoke the login API and returns the result
    /// - Parameters:
    ///   - email: email of user
    ///   - password: password of user
    func loginUser(_ email: String, _ password: String) {
        repo.loginUser(email: email, password: password) { userData in
            DispatchQueue.main.async { [weak self] in
                
                guard let `self` = self else {
                    return
                }
                
                if let userData = userData {
                    
                    self.loggedInUser = userData
                    _ = self.onLoginSuccess?()
                    
                } else {
                    
                    self.onShowError?("Something went wrong! Please try again")
                    
                }
            }
        } onFailure: { errorMessage in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.onShowError?(errorMessage ?? "Something went wrong! Please try again")
            }
        }
    }
}

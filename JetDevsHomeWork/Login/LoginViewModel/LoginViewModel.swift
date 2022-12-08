//
//  LoginViewModel.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation
import RxSwift

class LoginViewModel {

    private var showLoading: (() -> Void)?
    private var hideLoading: (() -> Void)?
    var loggedInUser: User?
    private lazy var repo = { LoginRepo() }()
    
    init(showLoader: (() -> Void)?, hideLoader: (() -> Void)?) {
        
        self.showLoading = showLoader
        self.hideLoading = hideLoader
    }
    
    /// Will invoke the login API and returns the result
    /// - Parameters:
    ///   - email: email of user
    ///   - password: password of user
    func loginUser(_ email: String, _ password: String) -> Observable<User> {
        
        return Observable.create { observer in
            _ = self.showLoading?()
            self.repo.loginUser(email: email, password: password) { userData in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    _ = self.hideLoading?()
                    if let userData = userData {
                        self.loggedInUser = userData
                        observer.onNext(userData)
                    } else {
                        observer.onError(APIError.somethingWentWrong)
                    }
                }
                
            } onFailure: { errorMessage in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    _ = self.hideLoading?()
                    observer.onError(APIError.error(errorMessage ?? ErrorMessages.somethingWentWrong))
                }
            }
            
            return Disposables.create {
            }
        }
    }
}

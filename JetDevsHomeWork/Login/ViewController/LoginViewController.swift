//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by Admin on 05/12/22.
//

import UIKit
import RxRelay
import RxSwift

protocol LoginDelegate: AnyObject {
    
    func loginDidSucceed(forUser: User)
    
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var stackInputFields: UIStackView!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    private lazy var txtEmail: CustomUITextField? = {
        
        return CustomUITextField.instanciate()
        
    }()
    
    private lazy var txtPassword: CustomUITextField? = {
        
        return CustomUITextField.instanciate()
        
    }()

    let disposeBag = DisposeBag()
    
    lazy var repo = { LoginRepo() }()
    
    private var textInputValidationStatus = BehaviorRelay(value: (false, false))
    
    weak var delegate: LoginDelegate?
    
    fileprivate func textFieldSetups() {
        
        if let txtEmail = txtEmail {
            if let txtPassword = txtPassword {
                
                stackInputFields.addArrangedSubview(txtEmail)
                txtEmail.setup(placeholder: "Email", validationRule: .email, errorMessage: "This is a invalid email") { isValidated in
                    self.textInputValidationStatus.accept((isValidated, self.textInputValidationStatus.value.1))
                }
                txtEmail.txtfield.textContentType = .emailAddress
                
                stackInputFields.addArrangedSubview(txtPassword)
                txtPassword.setup(placeholder: "Password", validationRule: .password, errorMessage: "Passwords require at least 1 uppercase, 1 lowercase, and 1 number") { isValidated in
                    self.textInputValidationStatus.accept((self.textInputValidationStatus.value.0, isValidated))
                }
                txtPassword.txtfield.isSecureTextEntry = true
                txtPassword.txtfield.textContentType = .password
                
            }
        }
    }
    
    @IBAction func actionclose(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.setEnable(false)
        textFieldSetups()
        
        textInputValidationStatus.subscribe(onNext: { status in
            self.btnLogin.setEnable(status.0 == true && status.1 == true)
          })
          .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func loginUser(_ email: String, _ password: String) {
        repo.loginUser(email: email, password: password) { userData in
            
            DispatchQueue.main.async { [weak self] in
                
                guard let `self` = self else {
                    return
                }
                
                if let userData = userData {
                    self.delegate?.loginDidSucceed(forUser: userData)
                    self.dismiss(animated: true)
                } else {
                    self.showErrorAlert("Something went wrong! Please try again")
                }
            }
        } onFailure: { errorMessage in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {
                    return
                }
                
                self.showErrorAlert(errorMessage ?? "Something went wrong! Please try again")
            }
        }
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        if let email = txtEmail?.text {
            
            if let password = txtPassword?.text {
                
                loginUser(email, password)
                
            }
        }
    }
}

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
    
    /// Will get invoked when login is successfull
    /// - Parameter withViewModel: login view model object
    func loginDidSucceed(withUser: User?)
    
}

class LoginViewController: UIViewController {

    // MARK: - UI Properties
    @IBOutlet private weak var stackInputFields: UIStackView!
    @IBOutlet private weak var btnLogin: UIButton!
    private lazy var txtEmail: CustomUITextField? = {
        return CustomUITextField.instanciate()
    }()
    private lazy var txtPassword: CustomUITextField? = {
        return CustomUITextField.instanciate()
    }()

    // MARK: - Class Properties
    let disposeBag = DisposeBag()
    private var textInputValidationStatus = BehaviorRelay(value: (false, false))
    weak var delegate: LoginDelegate?
    var viewModel: LoginViewModel?
    
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
        self.dismiss(animated: true)
    }
    
    fileprivate func viewModelSetups() {
        viewModel = LoginViewModel(showLoader: {
            self.btnLogin.setTitle("Loading....", for: .normal)
            self.btnLogin.isEnabled = false
        }, hideLoader: {
            self.btnLogin.setTitle("Login", for: .normal)
            self.btnLogin.isEnabled = true
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.setEnable(false)
        textFieldSetups()
        
        /// Subscribing to changes of validation status to manage button state
        textInputValidationStatus.subscribe(onNext: { status in
            self.btnLogin.setEnable(status.0 == true && status.1 == true)
          })
          .disposed(by: disposeBag)
        
        viewModelSetups()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func actionLogin(_ sender: Any) {
        if let email = txtEmail?.text {
            if let password = txtPassword?.text {
                viewModel?.loginUser(email, password).subscribe(onNext: { userData in
                    self.delegate?.loginDidSucceed(withUser: userData)
                    self.dismiss(animated: true)
                }, onError: { error in
                    self.showErrorAlert((error as? APIError)?.errorMessage ?? ErrorMessages.somethingWentWrong)
                }).disposed(by: disposeBag)
            }
        }
    }
}

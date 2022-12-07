//
//  CustomUITextField.swift
//  JetDevsHomeWork
//
//  Created by Admin on 05/12/22.
//

import UIKit
import RxCocoa

class CustomUITextField: UIView {

    @IBOutlet private weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtfield: UITextField!
    
    @IBOutlet private weak var viewContainer: UIView!
    
    @IBOutlet private weak var lblErrorMessage: UILabel!
    
    var text: String? {
        return txtfield.text
    }
        
    lazy var textValidator: Validator = {
        return Validator()
    }()
    
    var isValidated: ((Bool) -> Void)?
    
    static func instanciate() -> CustomUITextField? {
        
        guard
            let nib = Bundle.main.loadNibNamed("CustomUITextField", owner: nil, options: nil)
        else {
            print("missing expected nib named: CustomUITextField")
            return nil
        }
        
        guard
            let view = nib.first as? Self
        else {
            print("view of type \(Self.self) not found in \(nib)")
            return nil
        }
        
        return view
        
    }
    
    fileprivate func setupValidator(_ validationRule: Validator.ValidationRule) {
        _ = txtfield.rx.controlEvent(.editingChanged).asObservable().subscribe { [weak self] _ in
            
            guard let `self` = self else {
                return
            }
            
            if let text = self.txtfield.text {
                let isTextValidated = self.textValidator.validate(text, rule: validationRule)
                self.isValidated?(isTextValidated)
                self.lblErrorMessage.isHidden = isTextValidated
            }
        }
    }
    
    func setup(placeholder: String, validationRule: Validator.ValidationRule, errorMessage: String, isValidated: ((Bool) -> Void)? = nil) {
        
        self.isValidated = isValidated
        lblTitle.text = placeholder
        txtfield.placeholder = placeholder
        viewContainer.layer.borderColor = UIColor.lightGray.cgColor
        viewContainer.layer.borderWidth = 0.75
        lblErrorMessage.text = errorMessage
        setupValidator(validationRule)
    }
    
    func showErrorMessage(_ message: String) {
        self.lblErrorMessage.text = message
    }
    
}

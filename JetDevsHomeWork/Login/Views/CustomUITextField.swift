//
//  CustomUITextField.swift
//  JetDevsHomeWork
//
//  Created by Admin on 05/12/22.
//

import UIKit

class CustomUITextField: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtfield: UITextField!
    
    @IBOutlet weak var viewContainer: UIView!
    
    static func instanciate() -> CustomUITextField?{
        
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
    
    func setup(placeholder : String){
        
        lblTitle.text = placeholder
        txtfield.placeholder = placeholder
        viewContainer.layer.borderColor = UIColor.lightGray.cgColor
        viewContainer.layer.borderWidth = 0.75
        
    }
    
}

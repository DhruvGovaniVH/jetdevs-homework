//
//  InputValidator.swift
//  JetDevsHomeWork
//
//  Created by Admin on 06/12/22.
//

import Foundation

class Validator {
    
    enum ValidationRule: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
    }
    
    /// It will validate the text based on passed
    /// - Parameters:
    ///   - text: text to validate
    ///   - rule: rule to be use to validate
    /// - Returns: return result of validation
    func validate(_ text: String, rule: ValidationRule) -> Bool {
        
        let textPred = NSPredicate(format: "SELF MATCHES %@", rule.rawValue)
        return textPred.evaluate(with: text)
        
    }
    
}

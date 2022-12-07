//
//  UIViewController+Extension.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
        
    }
    
}

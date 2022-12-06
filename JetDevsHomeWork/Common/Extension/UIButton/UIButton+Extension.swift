//
//  UIButton+Extension.swift
//  JetDevsHomeWork
//
//  Created by Admin on 06/12/22.
//

import Foundation
import UIKit
extension UIButton {
    
    func setEnable(_ enabled: Bool) {
        
        if enabled {
            
            self.isEnabled = true
            self.backgroundColor = #colorLiteral(red: 0.2016438842, green: 0.399077177, blue: 0.6221905351, alpha: 1)
            
        } else {
            
            self.isEnabled = false
            self.backgroundColor = .lightGray

        }
        
    }
    
}

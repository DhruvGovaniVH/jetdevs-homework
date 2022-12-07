//
//  CustomError.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

protocol CustomError{
 
    var errorCode: Int { get }
    var errorMessage: String { get }
    
}

enum APIError : CustomError, Error{
         
    case error(_ message: String)
    
    var errorCode: Int{
        switch self {
        case .error:
            return -1
        }
    }
    
    var errorMessage: String{
        switch self {
        case .error(let msg):
            return msg
        }
    }
    
}

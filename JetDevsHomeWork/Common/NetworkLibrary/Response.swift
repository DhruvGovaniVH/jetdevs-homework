//
//  Response.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

struct Response<T>: Codable where T : Codable{
    let result: Int
    let errorMessage: String
    let data: T

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
        case data
    }
}

//
//  User.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

struct UserData: Codable {
    
    let user: User
    
}

struct User: Codable {
    
    let userID: Int
    let userName: String
    let userProfileURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userProfileURL = "user_profile_url"
        case createdAt = "created_at"
    }
    
    func getAccountSince() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self.createdAt) {
            let diff = (Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0)
            return "Created \(diff) days ago"
        } else {
            return ""
        }
        
    }
}

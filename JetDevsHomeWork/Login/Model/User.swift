//
//  User.swift
//  JetDevsHomeWork
//
//  Created by Admin on 07/12/22.
//

import Foundation

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
}

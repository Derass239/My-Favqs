//
//  User.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    
    static var currentUser: User?
    
    let login: String
    let picURL: String
    let publicFavoritesCount, followers, following: Int
    let pro: Bool
    let accountDetails: AccountDetails

    enum CodingKeys: String, CodingKey {
        case login
        case picURL = "pic_url"
        case publicFavoritesCount = "public_favorites_count"
        case followers, following, pro
        case accountDetails = "account_details"
    }
}

// MARK: - AccountDetails
struct AccountDetails: Codable {
    let email: String
    let privateFavoritesCount: Int
    let activeThemeID: Int?
    let proExpiration: String?

    enum CodingKeys: String, CodingKey {
        case email
        case privateFavoritesCount = "private_favorites_count"
        case activeThemeID = "active_theme_id"
        case proExpiration = "pro_expiration"
    }
}

// MARK: - UserDetails
struct UserDetails: Codable {
    let favorite, upvote, downvote, hidden: Bool
}

// MARK: - UserLogin
struct UserLogin: Codable {
    let userToken, login, email: String?
    let errorCode: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login, email
        case errorCode = "error_code"
        case message
    }
}

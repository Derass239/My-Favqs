//
//  Quote.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

// MARK: - Quotes
struct Quotes: Codable {
    let page: Int
    let lastPage: Bool
    let quotes: [Quote]

    enum CodingKeys: String, CodingKey {
        case page
        case lastPage = "last_page"
        case quotes
    }
}

// MARK: - Quote
struct Quote: Codable {
    let id: Int
    let dialogue, quotePrivate: Bool
    let tags: [String]
    let url: String
    let favoritesCount, upvotesCount, downvotesCount: Int
    let author, authorPermalink, body: String
    let userDetails: UserDetails?

    enum CodingKeys: String, CodingKey {
        case id, dialogue
        case quotePrivate = "private"
        case tags, url
        case favoritesCount = "favorites_count"
        case upvotesCount = "upvotes_count"
        case downvotesCount = "downvotes_count"
        case author
        case authorPermalink = "author_permalink"
        case body
        case userDetails = "user_details"
    }
}

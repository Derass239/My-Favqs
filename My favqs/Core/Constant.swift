//
//  Constant.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation


struct APIPath {
    static let session          = baseURL+"session"
    static let users            = baseURL+"users/"
    static let quotes           = baseURL+"quotes/"
    static let qotd             = baseURL+"qotd"
    
    
    
    static var baseURL: String {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String
        if baseUrl != nil && !(baseUrl?.isEmpty)! {
            return baseUrl!
        }
        
        return ""
    }
    
    static var appToken: String {
        let token = Bundle.main.object(forInfoDictionaryKey: "APP_TOKEN") as? String
        if token != nil && !(token?.isEmpty)! {
            return token!
        }
        
        return ""
    }
}

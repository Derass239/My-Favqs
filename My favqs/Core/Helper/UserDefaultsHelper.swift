//
//  UserDefaultsHelper.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

enum UserDefaultsKey :String {
    case isLogged = "isLogged"
    case token = "token"
    case login = "login"
}

class UserDefaultsHelper {
    
    //MARK: - Logging
    
    static func isLogged() -> Bool {
           
           let preferences = UserDefaults.standard
           let isLoggedKey = UserDefaultsKey.isLogged.rawValue
           
           if preferences.object(forKey: isLoggedKey) == nil {
               return false
           } else {
               return preferences.bool(forKey: isLoggedKey)
           }
        
       }
    
    static func setLogged(logged :Bool) {
        
        let preferences = UserDefaults.standard
        let isLoggedKey = UserDefaultsKey.isLogged.rawValue
        
        preferences.set(logged, forKey: isLoggedKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
        
        if logged == false { UserDefaultsHelper.set(token: "") }
    }
    
    //MARK: - Token
    
    static func getToken() -> String? {
        
        let preferences = UserDefaults.standard
        let tokenKey = UserDefaultsKey.token.rawValue
        
        if preferences.object(forKey: tokenKey) == nil {
            return nil
        } else {
            let token = preferences.string(forKey: tokenKey)
            return token?.isEmpty == true ? nil : token
        }
    }
    
    static func set(token: String) {
        
        let preferences = UserDefaults.standard
        let tokenKey = UserDefaultsKey.token.rawValue
        
        preferences.set(token, forKey: tokenKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
    }
    
    //MARK: - Login
    
    static func getLogin() -> String? {
        let preferences = UserDefaults.standard
        let loginKey = UserDefaultsKey.login.rawValue
        
        if preferences.object(forKey: loginKey) == nil {
            return nil
        } else {
            let login = preferences.string(forKey: loginKey)
            return login?.isEmpty == true ? nil : login
        }
    }
    
    static func set(login: String) {
        
        let preferences = UserDefaults.standard
        let loginKey = UserDefaultsKey.login.rawValue
        
        preferences.set(login, forKey: loginKey)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
    }
}

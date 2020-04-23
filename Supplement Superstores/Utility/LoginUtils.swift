//
//  LoginUtils.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct LoginUtils {
    
    static let sharedInstance = LoginUtils()
    private init() {}
   func saveUserToDefaults(login: SessionModel) {
       let defaults = UserDefaults.standard
       if let user = login.user {
           let encoder = JSONEncoder()
           
           if let encoded = try? encoder.encode(user) {
               
            defaults.set(encoded, forKey: "User")
            defaults.set(login.token, forKey: "auth_Token")
            defaults.synchronize()
               
           }
       }
    }
     
    func getUserToDefaults() -> User? {
        let defaults = UserDefaults.standard
        var user: User? = nil
       if let currentUser = defaults.object(forKey: "User") as? Data {
        let decoder = JSONDecoder()
        let loadedUser = try? decoder.decode(User.self, from: currentUser)
            user = loadedUser
        }
        return user
   }
    
    func getUserToken() -> String? {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "auth_Token")
        return token
      }
    
    func removeUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "User")
        defaults.removeObject(forKey: "auth_Token")
      //  re(forKey: "User")
        defaults.synchronize()
         
      }
}

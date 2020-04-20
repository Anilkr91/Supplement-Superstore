//
//  User.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//


import Foundation

struct SessionModel: Decodable  {
    let token : String?
    let user: User?
   
}

struct User: Decodable, Encodable   {
    let pk : String?
    let username: String?
    let email: String?
    let first_name : String?
    let last_name: String?
        
}

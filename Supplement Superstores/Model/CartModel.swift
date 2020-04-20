//
//  CartModel.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

struct CartModel:  Decodable, Encodable  {
    
    let price: String?
    let title: String?
    let productId: String?
    var quantity: Int?
   
}

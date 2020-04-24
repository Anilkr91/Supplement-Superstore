//
//  CartModel.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

struct CartModel:  Decodable, Encodable  {
    
    let discounted_price: String?
    let price: String?
    let title: String?
    let description: String?
    let productId: String?
    var quantity: Int?
    
}


struct PlaceOrderModel:  Decodable, Encodable  {
    
    let discounted_price: Int?
    let price: Int?
    let title: String?
    let description: String?
    let productId: String?
    var quantity: Int?
    
    
    var dictionary: [String: Any] {
    return [
            "description": description ?? "",
            "discounted_price": discounted_price ?? 0,
            "id": productId ?? "",
            "price": price ?? 0,
            "title": title ?? "",
            "quantity": quantity ?? 1
        ]
    
    }
}

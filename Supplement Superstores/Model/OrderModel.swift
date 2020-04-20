//
//  OrderModel.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
struct orderModel: Decodable {
    
    let id : String?
    let total: String?
    let status: String?
    let status_verbose: String?
    let created: String?
    let items: [items]?
}

struct items: Decodable  {
    let quantity: Int?
    let item: itemDetail?
}

struct itemDetail: Decodable  {
    let id : String?
    let price: String?
    let title: String?
    let discounted_price: String?
}

struct AllOrderModel: Decodable {
    let all: [orderModel]?

  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}

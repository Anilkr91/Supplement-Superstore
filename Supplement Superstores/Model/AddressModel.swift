//
//  AddressModel.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct AddressModel: Decodable  {
    
    let id : String?
    let user: String?
    let line_1: String?
    let line_2: String?
    let line_3: String?
    let landmark: String?
    let country: String?
    let city: String?
    let state: String?
    let pincode: String?
    
}


struct AllAddressModel: Decodable {
  let all: [AddressModel]
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}

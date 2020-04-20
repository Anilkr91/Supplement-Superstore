//
//  ProductsService+GET.swift
//  Supplement Superstores
//
//  Created by mac on 15/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class ProductsGetService {

 static func executeRequest (params: [String:Any], successBlock:@escaping (_ result: AllProducts?) -> (), failureBlock:@escaping (String?) -> ()) {
    
   
    let urlString  = SSConstant.BASE_URL+"/api/v1/catalogue/products/"
    let header: HTTPHeaders = ["Content-Type" :"application/json"]
    
    AF.request(urlString,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseDecodable(of: AllProducts.self) { (response) -> Void in
        
        switch (response.result) {
        case .success:
            
          guard let products = response.value else { return }
          
          if products.all.count > 0 {
            successBlock(products)
          }
          
            break
        case .failure(let error):
                failureBlock(error.localizedDescription)
            
            break
            }
        }
    }
}

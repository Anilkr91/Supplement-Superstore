//
//  ProductImagesService+GET.swift
//  Supplement Superstores
//
//  Created by mac on 16/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class ProductImageGetService {

 static func executeRequest (id: String, successBlock:@escaping (_ result: [ProductImageModel]?) -> (), failureBlock:@escaping (String?) -> ()) {
    
   
    let urlString  = SSConstant.BASE_URL+"/api/v1/catalogue/product-images/?product__id=\(id)"
    let header: HTTPHeaders = ["Content-Type" :"application/json"]
    
   print(urlString)
    
 let r =   AF.request(urlString,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseDecodable(of: AllProductImages.self) { (response) -> Void in
        
        switch (response.result) {
        case .success:
            
          guard let products = response.value else { return }
          
          if products.all.count > 0 {
            successBlock(products.all)
          }
          
            break
        case .failure(let error):
                failureBlock(error.localizedDescription)
            
            break
            }
        }
    debugPrint(r)
    }
}

//
//  CategoriesService+GET.swift
//  Supplement Superstores
//
//  Created by mac on 15/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class CategoriesGetService {

 static func executeRequest (params: [String:Any], successBlock:@escaping (_ result: AllCategories?) -> (), failureBlock:@escaping (String?) -> ()) {
    
   
    let urlString  = SSConstant.BASE_URL+"/api/v1/catalogue/categories/"
    let header: HTTPHeaders = ["Content-Type" :"application/json"]
    
    AF.request(urlString,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseDecodable(of: AllCategories.self) { (response) -> Void in
        
        switch (response.result) {
        case .success:
            
          guard let categories = response.value else { return }
          
          if categories.all.count > 0 {
            successBlock(categories)
          }
          
            break
        case .failure(let error as Error):
                failureBlock(error.localizedDescription)
            
            break
            }
        }
    }
}

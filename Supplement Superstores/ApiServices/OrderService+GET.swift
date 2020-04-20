//
//  OrderService+GET.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class OrderGetService {

 static func executeRequest (params: [String:Any], successBlock:@escaping (_ result: AllOrderModel?) -> (), failureBlock:@escaping (String?) -> ()) {
    
   
    let urlString  = SSConstant.BASE_URL+"/api/v1/fulfillment/orders/"
    let header: HTTPHeaders = [
        "Authorization": "JWT \(LoginUtils.sharedInstance.getUserToken() ?? "")",
        "Content-Type" :"application/json"
    ]
    
    AF.request(urlString,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseDecodable(of: AllOrderModel.self) { (response) -> Void in
        
        switch (response.result) {
        case .success:
            
          guard let orderInfo = response.value else { return }
                                  
            if orderInfo != nil {
                successBlock(orderInfo)
            }
          
            break
        case .failure(let error):
                failureBlock(error.localizedDescription)
            
            break
            }
        }
    }
}

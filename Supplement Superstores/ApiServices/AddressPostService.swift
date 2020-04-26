//
//  AddressPostService.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class AddressPostService {
    static func executeRequest ( params:[String: Any], successBlock:@escaping (_ result: AddressModel?) -> (), failureBlock:@escaping (String?) -> ()) {
        
        let urlString  = SSConstant.BASE_URL+"/api/v1/users/addresses/"
        let header: HTTPHeaders = [
            "Authorization": "JWT \(LoginUtils.sharedInstance.getUserToken() ?? "")",
            "Content-Type" :"application/json"
        ]
        
        AF.request(urlString,method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AddressModel.self) { (response) -> Void in
        
            switch response.result {
            case .success:
                
            guard let address = response.value else { return }
                         
                if address != nil {
                    successBlock(address)
                }
               
            case .failure:
                  do{
                    let JSONDict = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                    
                    let errorMessage = JSONDict.value(forKey: "non_field_errors") as! [String]
                    failureBlock(errorMessage[0])
                                       
                    } catch{
                        failureBlock(error.localizedDescription)
                }
            }
        }
    }
}

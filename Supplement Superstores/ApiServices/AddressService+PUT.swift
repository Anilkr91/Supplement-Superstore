//
//  AddressService+PUT.swift
//  Supplement Superstores
//
//  Created by mac on 23/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class AddressPutService {
    static func executeRequest ( id: String, params:[String: Any], successBlock:@escaping (_ result: AllAddressModel?) -> (), failureBlock:@escaping (String?) -> ()) {
        
        let urlString  = SSConstant.BASE_URL+"/api/v1/users/addresses/\(id)"
        let header: HTTPHeaders = [
            "Authorization": "JWT \(LoginUtils.sharedInstance.getUserToken() ?? "")",
            "Content-Type" :"application/json"
        ]
        
        AF.request(urlString,method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AllAddressModel.self) { (response) -> Void in
        
            switch response.result {
            case .success:
                
            guard let addresses = response.value else { return }
                         
                if addresses != nil {
                    successBlock(addresses)
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

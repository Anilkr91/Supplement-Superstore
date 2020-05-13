//
//  RegisterPostService.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire

class RegisterPostService {
    static func executeRequest ( params:[String: Any], successBlock:@escaping (_ result: SessionModel?) -> (), failureBlock:@escaping (String?) -> ()) {
        
        let urlString  = SSConstant.BASE_URL+"/rest-auth/registration/"
        let header: HTTPHeaders = ["Content-Type" :"application/json"]
        
        AF.request(urlString,method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SessionModel.self) { (response) -> Void in
        
            switch response.result {
            case .success(let value) :
                
            guard let session = response.value else { return }
                         
                if session != nil {
                    successBlock(session)
                }
               
            case .failure(let error):
                  do{
                    let JSONDict = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                                    
                    
                    var mobile = ""
                     var password = ""
                   if let result = JSONDict.value(forKey: "mobile") as? [String]{
                    mobile = result.first ?? ""
                    }
                    
                    if let result2 = JSONDict.value(forKey: "password1") as? [String] {
                        password = result2.first ?? ""
                    }
                       
                    failureBlock("\(mobile)\n \(password)")
                                       
                    } catch{
                        failureBlock(error.localizedDescription)
                }
            }
        }
    }
}

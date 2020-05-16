//
//  QuoteService.swift
//  My favqs
//
//  Created by Valentin Limagne on 15/05/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let sharedInstance = RequestManager()
    private init() {}
    
    var sessionManager = Alamofire.Session.default
    var headers: HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": APIPath.appToken]
    
    private func performRequest<T:Decodable>(_ url: URLConvertible,
                                     method: HTTPMethod = .get,
                                     parameters: Parameters? = nil,
                                     decoder: JSONDecoder = JSONDecoder(),
                                     completion:@escaping (AFResult<T>)->Void) -> DataRequest {

        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        return AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                completion(response.result)
        }
    }
    
    func login(username: String, password: String, completion:@escaping(AFResult<UserLogin>)->Void) {
        _ = performRequest(APIPath.session,
                       method: .post,
                       parameters: ["user": ["login": username, "password": password]],
                       completion: completion)
    }
    
    func whoAmI(username: String, completion:@escaping(AFResult<User>)->Void) {
        let safeUrl = "\(APIPath.users)\(username)"
        
        _ = performRequest(safeUrl,
                           method: .get,
                           completion: completion)
    }
    
    func getLikedQuotes(username: String, completion:@escaping(AFResult<Quotes>) -> Void) {
        let safeUrl = "\(APIPath.quotes)?filter=\(username)&type=user"
        
        _ = performRequest(safeUrl,
                           completion: completion)
    }
    
}

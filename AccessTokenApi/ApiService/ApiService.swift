//
//  ApiService.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol {
    func objectRequest<T:Codable>(from apiurl:String, params:Parameters,method:HTTPMethod, handler: @escaping (Result<T,Error>) -> Void)
    func makeRequest<T:Codable>(from apiurl:String,method:HTTPMethod, params:Parameters, token: String, handler: @escaping (Result<T,Error>) -> Void )
//    func PostTravel<T:Codable>(from apiurl:String,method:HTTPMethod, params:Travel, token: String, handler: @escaping (Result<T,Error>) -> Void )
    
}

class ApiService:ApiServiceProtocol {
    func makeRequest<T:Codable>(from apiurl: String, method: HTTPMethod, params:Parameters, token: String,handler: @escaping (Result<T, Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(token)",
            "Accept": "application/json"
        ]
        AF.request(apiurl,
                   method: method,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseDecodable(of:T.self) { response  in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        handler(.success(decodedData as! T))
                    } catch {
                        print("Error: \(error)")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func objectRequest<T:Codable>(from apiurl: String, params: Parameters, method: HTTPMethod, handler: @escaping (Result<T, Error>) -> Void) {
        AF.request(apiurl,
                   method: method,
                   parameters: params,
                   encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    handler(.success(decodedData))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    
  
  
    
}

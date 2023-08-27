//
//  ApiService.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol {
    
    func objectRequest<T:Codable>(urlConvertible: Router,handler: @escaping (Result<T,Error>) -> Void)
    func makeRequest<T:Codable>(urlConvertible:Router,handler: @escaping (Result<T,Error>) -> Void)
    
}

class ApiService:ApiServiceProtocol {
    func makeRequest<T:Codable>(urlConvertible: Router, handler: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlConvertible).responseDecodable(of:T.self) { response  in
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
    
    
    func objectRequest<T:Codable>(urlConvertible: Router, handler: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlConvertible).responseDecodable(of:T.self) { response  in
            
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
}




//
//  LoginVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire


class LoginVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
        
    func login(params: [String:String],handler: @escaping (()->())) {

//        apiService.objectRequest(from: EndPoint.login.apiUrl, params: params, method: .post) { (result:Result<LoginResponse,Error>) in
//            switch result {
//
//            case .success(let success):
//                let data = Data(success.accessToken.utf8)
//                self.saveToken(data: data)
//                handler()
//            case .failure(let err):
//                print(err)
//            }
//        }
        apiService.objectRequest(urlConvertible: Router.login(params: params)) { 
            (result:Result<LoginResponse,Error>) in
                switch result {

                case .success(let success):
                    let data = Data(success.accessToken.utf8)
                    self.saveToken(data: data)
                    handler()
                case .failure(let err):
                    print(err)
                }
        }
    }
    
    
    func login2 (params: [String:String],method:HTTPMethod,handler: @escaping (()->())) {
     
       
        AF.request(Router.login(params: params)).responseDecodable(of:LoginResponse.self) { response in
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(LoginResponse.self, from: data)
                        print(decodedData.accessToken)
                        handler()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    

    func saveToken(data:Data) {
        KeychainHelper.shared.save(data, service: "access-token", account: "api.Iosclass")
    }
    
    func readToken() {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return}
        let tokenstr = String(data: token, encoding: .utf8)
        print("kaydedilen token : \(tokenstr)")
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
}
    

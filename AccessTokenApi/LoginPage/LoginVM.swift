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
    

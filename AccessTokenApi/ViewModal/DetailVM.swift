//
//  DetailVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire
class DetailVM {
    
    var closure: ((User)->())?
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    
    
    func fetchData(handler:@escaping ((User)->())) {
        apiService.makeRequest(from: EndPoint.me.apiUrl, method: .get, params: [:], token: getTokenFromChain()) { (result:Result<User,Error>) in
            switch result {
            case .success(let success):
               handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
}

//
//  AddTravelVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 19.08.2023.
//

import Foundation

class AddTravelVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func addTravel(body: [String:Any]) {
        print(self.getTokenFromChain())
        apiService.makeRequest(from: EndPoint.addTravel.apiUrl, method: .post, params: body, token: getTokenFromChain()) {
            (result:Result<AddTravelResponse,Error>) in
          
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
}

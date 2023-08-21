//
//  RegisterVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import Foundation

class RegisterVM {
    
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    
    

    func register(params: [String:String], handler: @escaping ((RegisterResponse)->())  ) {
  
    apiService.objectRequest(from: EndPoint.register.apiUrl, params: params, method: .post) { (result:(Result<RegisterResponse,Error>)) in
    
        switch result {
        case .success(let success):
            print(success)
            handler(success)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
   
}



}

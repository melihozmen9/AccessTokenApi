//
//  EditProfileVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 5.09.2023.
//

import Foundation

class EditProfileVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var statusAlert: (()->())?
    
    func editProfile(body: [String:String]) {
        apiService.objectRequest(urlConvertible: Router.editProfile(params: body)) { (result:Result<ProfileResponse,Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//
//  AddTravelVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 19.08.2023.
//

import Foundation
import UIKit
import Alamofire

class AddTravelVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
//    let filePath = Bundle.main.url(forResource: "helsinki", withExtension: "jpg")
//    let mimeType = filePath?.getMimeType
//    //MultipartFormData(fileManager: <#T##FileManager#>, boundary: <#T##String?#>)
    
    func uploadImage(image: UIImage){
        
        //FIXME: - Bu apiservice'te bir fonksiyona dönüştürülmeli. andler'ı oalcak. ve handler'ını burada cağırarak success ce fail' göre veriyi al. ardından gidip bunun için ayrı router yazarsın. 
        let headers : HTTPHeaders =  ["Authorization": "Basic eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmdWxsX25hbWUiOiJNZWxpaG96bSIsImlkIjoiNWZiMWExYjYtOWVjNi00N2Y5LWEwODAtNGMxYzFlYzAzOWJmIiwicm9sZSI6InVzZXIiLCJleHAiOjE2OTI5NzU5MTl9.78mLFvSf1A-tQYu0Zb4u0yMnFmDsLcxrPI1SdKeTBBw",
                        "Accept": "application/json"]
        AF.upload(multipartFormData: { multipart in
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                           multipart.append(imageData, withName: "file", fileName: "helsinki.jpg", mimeType: "image/jpeg")
                       }
            
        }, to: "https://api.iosclass.live/v1/upload",
                  method: .post,
                  headers: headers).responseDecodable(of:UploadResponse.self) { response in
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(UploadResponse.self, from: data)
                        print(decodedData.urls)
                    } catch {
                        print("Error: \(error)")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        //makeRequest(urlConvertible: Router.upload(params: item)) { (result:Result<UploadResponse,Error>) in
//            switch result {
//            case .success(let success):
//                print(success.urls[0])
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
        //}
    }
    
    func addTravel(body: [String:Any]) {
        apiService.makeRequest(urlConvertible: Router.postPlace(params: body)) {
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

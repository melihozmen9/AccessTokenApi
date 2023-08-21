//
//  VisitVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 21.08.2023.
//

import Foundation

class VisitVM {
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var travelArray: [TravelItem]?
    var reloadTableView: (()->())?
    
    func fetchTravels() {
        apiService.makeRequest(from: EndPoint.listTravel.apiUrl, method: .get, params: [:], token: getTokenFromChain()) { (result:Result<TravelData,Error>) in
            switch result {
            case .success(let success):
                print(success.data.travels[0].location)
                self.travelArray = success.data.travels
                self.reloadTableView!()
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
    
    
    
    
    
    
    
    
    
    //MARK: - DataSource
    
    func getNumberOfRowsInSection() -> Int {
        guard let travelArray = travelArray else {return 0 }
        return travelArray.count
    }
    
    func getCellForRowAt(indexpath: IndexPath) -> TravelItem? {
        guard let travelArray = travelArray else {  return nil  }

        return travelArray[indexpath.row]
    }
}

//
//  HomeVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 1.09.2023.
//

import Foundation
class HomeVM {
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    let array = ["Popular Places", "My Visits", "New Places"]
    var myVisitsArray: [Visits]?
    func getHeaderNameForSection(section:Int) -> String {
        return array[section]
    }
    
    func getAddedPlaces() {
        apiService.makeRequest(urlConvertible: Router.myAllVisits) { (result:Result<TravelData,Error>) in
            switch result {
            case .success(let success):
                let value = success.data.visits
                self.myVisitsArray = value
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

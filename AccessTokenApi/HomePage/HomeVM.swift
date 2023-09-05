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
    
    let array = ["Popular Places", "My Added Places", "New Places"]
    var myVisitsArray: [Visits]?
    func getHeaderNameForSection(section:Int) -> String {
        return array[section]
    }
    
    func getAddedPlaces() {
        apiService.makeRequest(urlConvertible: Router.getMyAddedPlacesLimit(limit: 5)) { (result:Result<TravelData,Error>) in
            switch result {
            case .success(let success):
                let value = success.data.visits
                self.myVisitsArray = value
                print(value)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getPopularPlaces() {
        apiService.objectRequest(urlConvertible: Router.getPopularPlacesLimit(limit: 5)) { (result:Result<PlacesData,Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getLastPlaces() {
        apiService.makeRequest(urlConvertible: Router.getLastPlacesLimit(limit: 5)) { (result:Result<PlacesData,Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
  
}

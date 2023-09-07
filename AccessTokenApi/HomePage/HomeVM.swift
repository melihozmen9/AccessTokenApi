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
    
    let sectionNames = ["Popular Places", "Last Places"]
    
    func getHeaderNameForSection(section:Int) -> String {
        return sectionNames[section]
    }
    
    var popularPlaces: [PlaceItem]?
    
    var lastPlaces: [PlaceItem]?
    
    func getPopularPlaces(handler: @escaping (()->())) {
        apiService.makeRequest(urlConvertible: Router.getPopularPlaces(limit: 5)) { (result:Result<PlacesData,Error>) in
            switch result {
            case .success(let success):
                self.popularPlaces = success.data.places
                handler()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getLastPlaces(handler: @escaping (()->())) {
        apiService.makeRequest(urlConvertible: Router.getLastPlaces(limit: 5)) { (result:Result<PlacesData,Error>) in
            switch result {
            case .success(let success):
                self.lastPlaces = success.data.places
                handler()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

  
}














//    var myVisitsArray: [PlaceItem]? {
//        didSet {
//            guard let reloadCollection = reloadCollection else {return}
//            reloadCollection()
//        }
//    }

//    {
//        didSet {
//            guard let reloadCollection = reloadCollection, let popularPlaces = popularPlaces else {return}
//            reloadCollection(popularPlaces)
//        }
//    }
    
   
//    {
//        didSet {
//            guard let reloadCollection = reloadCollection,let lastPlaces = lastPlaces else {return}
//            reloadCollection(lastPlaces)
//        }
//    }
    
    //var reloadCollection: (([PlaceItem])->())?
  
    
//    func getAddedPlaces(handler:(()->())) {
//        apiService.makeRequest(urlConvertible: Router.getMyAddedPlaces(limit: 5)) { (result:Result<PlacesData,Error>) in
//            switch result {
//            case .success(let success):
//                let value = success.data.places
//                self.myVisitsArray = value
//
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }

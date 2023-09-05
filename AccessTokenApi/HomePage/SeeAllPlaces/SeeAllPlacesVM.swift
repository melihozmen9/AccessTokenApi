

import Foundation


class SeeAllPlacesVM {
    
    private var popularPlaces = [PlaceItem]()
    private var myAddedPlaces = [PlaceItem]()
    private var lastPlaces = [PlaceItem]()

    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func getPlaces (places:String, callback: @escaping ()->Void) {
        if places == "popularPlaces"{
            DispatchQueue.global().async { [self] in
                apiService.makeRequest(urlConvertible: Router.getPopularPlaces) { (result:Result<PlacesData,Error>) in
                    switch result {
                    case .success(let data):
                        self.popularPlaces = data.data.places
                        DispatchQueue.main.async {
                            callback()
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        } else if places == "myAddedPlaces"{
            DispatchQueue.global().async { [self] in
                apiService.makeRequest(urlConvertible: Router.getMyAddedPlaces) { (result:Result<PlacesData,Error>) in
                    switch result {
                    case .success(let data):
                        self.myAddedPlaces = data.data.places
                        DispatchQueue.main.async {
                            callback()
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        } else if places == "lastPlaces" {
            DispatchQueue.global().async { [self] in
                apiService.makeRequest(urlConvertible: Router.getLastPlaces) { (result:Result<PlacesData,Error>) in
                    switch result {
                    case .success(let data):
                        self.lastPlaces = data.data.places
                        DispatchQueue.main.async {
                            callback()
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
        
    }
    
    func getPlacesIndex(index:Int, places:String) -> PlaceItem? {
        var item:PlaceItem?
        if places == "popularPlaces"{
            item =  popularPlaces[index]
        } else if places == "myAddedPlaces"{
            item = myAddedPlaces[index]
        } else if places == "lastPlaces" {
            item = lastPlaces[index]
        }
        
        return item
    }
    
    func countOfPlaces(places:String) -> Int {
        var count = 0
        
        if places == "popularPlaces"{
            count = popularPlaces.count
        } else if places == "myAddedPlaces"{
            count = myAddedPlaces.count
        } else if places == "lastPlaces" {
            count = lastPlaces.count
        }
        return count
    }
    
    
    func sortArray (places: String, callback: @escaping () -> Void ) {
        if places == "popularPlaces"{
            popularPlaces = popularPlaces.sorted { $0.title < $1.title }
        } else if places == "myAddedPlaces"{
            myAddedPlaces = myAddedPlaces.sorted { $0.title < $1.title }
        } else if places == "lastPlaces" {
            lastPlaces = lastPlaces.sorted { $0.title < $1.title }
        }
    }
    
    
}

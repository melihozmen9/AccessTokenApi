

import Foundation


class SeeAllPlacesVM {
    
    private var popularPlaces = [PlaceItem]()
    private var myAddedPlaces = [PlaceItem]()
    private var lastPlaces = [PlaceItem]()

    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func getPopularPlaces( callback: @escaping ()->Void) {
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
    }
    
    func getMyAddedPlaces (callback: @escaping ()->Void) {
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
    }
    
    func getLastPlaces( callback: @escaping ()->Void) {
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
    
    func getPopularPlace(index:Int) -> PlaceItem? {
        return popularPlaces[index]
    }
    
    func getMyAddedPlace(index:Int) -> PlaceItem? {
        return myAddedPlaces[index]
    }
    
    func getLastPlace(index:Int) -> PlaceItem? {
        return lastPlaces[index]
    }
    
    
    func countOfPopularPlaces() -> Int {
        return popularPlaces.count
    }

    func countOfMyAddedPlaces() -> Int {
        return myAddedPlaces.count
    }

    func countOfLastPlaces() -> Int {
        return lastPlaces.count
    }
    
    
}



import Foundation


class SeeAllPlacesVM {
    
    var popularPlaces = [PlaceItem]()
    var lasPlaces = [PlaceItem]()
    
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
    
    func getLastPlaces( callback: @escaping ()->Void) {
        DispatchQueue.global().async { [self] in
            apiService.makeRequest(urlConvertible: Router.getLastPlaces) { (result:Result<PlacesData,Error>) in
                switch result {
                case .success(let data):
                    self.lasPlaces = data.data.places
                    DispatchQueue.main.async {
                        callback()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func countOfPopularPlaces() -> Int {
        return popularPlaces.count
    }
    
    func countOfLastPlaces() -> Int {
        return lasPlaces.count
    }
    
}

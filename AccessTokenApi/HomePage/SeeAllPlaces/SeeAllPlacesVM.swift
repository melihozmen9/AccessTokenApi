

import Foundation


class SeeAllPlacesVM {
    
    private var placeArray = [PlaceItem]()
    var place:String?
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    

func getPlaces (callback: @escaping ()->Void) {
    DispatchQueue.global().async { [self] in
        let router: Router
        switch self.place {
        case "popularPlaces":
            router = Router.getPopularPlaces
        case "myAddedPlaces":
            router = Router.getMyAddedPlaces
        case "lastPlaces":
            router = Router.getLastPlaces
        default:
            fatalError("Invalid place value")
        }
        
        apiService.makeRequest(urlConvertible: router) { (result:Result<PlacesData,Error>) in
            switch result {
            case .success(let data):
                self.placeArray = data.data.places
                DispatchQueue.main.async {
                    callback()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

    func getPlacesIndex(index:Int) -> PlaceItem? {
        return placeArray[index]
    }

    func countOfPlaces() -> Int {
        return placeArray.count
    }


    func sortArray (ascending:Bool) {
        if ascending {
            placeArray = placeArray.sorted { $0.title.lowercased() < $1.title.lowercased() }
        } else {
            placeArray = placeArray.sorted { $0.title.lowercased() > $1.title.lowercased() }
        }
    }

    func setTitle() -> String {
        if place == "popularPlaces" {
            return "Popular Places"
        } else if place == "myAddedPlaces"{
            return "My Added Places"
        } else if place == "lastPlaces" {
            return "LastPlaces"
        }
        return ""
    }
    

}

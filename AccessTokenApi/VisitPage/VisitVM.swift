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
    
    var travelArray: [Visits]?
    var reloadTableView: (()->())?
    var onDataFetch: ((Bool) -> Void)?
    
    func fetchTravels() {
        
       
        self.onDataFetch?(true)
        apiService.makeRequest(urlConvertible: Router.myAllVisits) { (result:Result<TravelData,Error>) in
            
            switch result {
            case .success(let success):
               
                self.travelArray = success.data.visits
                guard let reloadTableView = self.reloadTableView else { return}
                sleep(1)
                reloadTableView()
                self.onDataFetch?(false)
            case .failure(let failure):
                print(failure)
                self.onDataFetch?(false)
            }
        }
    }

    
  
    
    
    
    
    
    
    
    
    
    //MARK: - DataSource
    
    func getNumberOfRowsInSection() -> Int {
        guard let travelArray = travelArray else {return 0 }
        return travelArray.count
    }
    
    func getObjectForRowAt(indexpath: IndexPath) -> VisitPlace? {
        guard let travelArray = travelArray else {  return nil  }
        return travelArray[indexpath.row].place
    }
}

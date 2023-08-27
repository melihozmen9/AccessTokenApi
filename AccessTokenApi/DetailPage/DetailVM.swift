//
//  DetailVM.swift
//  AccessTokenApi
//
//  Created by Kullanici on 17.08.2023.
//

import Foundation
import Alamofire
import UIKit
class DetailVM {
    
   
    let travelID :String?
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService(),id:String){
        self.apiService = apiService
        self.travelID = id
        getTravelItemByID()
        getGalleryItems()
    }
    
    var galleryImagesItem: [ImageItem]?
    
    var fillDetails: ((PlaceItem)->())?
    var reloadCollection: (()->())?
    
    func getTravelItemByID() {
       guard let travelID = travelID else { return   }
        apiService.makeRequest(urlConvertible: Router.travelID(id: travelID)) { (result:Result<TravelID,Error>) in
            switch result {
            case .success(let success):
                guard let fillDetails = self.fillDetails else { return}
                fillDetails(success.data.place)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getGalleryItems() {
        guard let travelID = travelID else { return }
         print(EndPoint.travelID(id: travelID).apiUrl)
        apiService.makeRequest(urlConvertible: Router.galleryID(id: travelID)) { (result:Result<GalleryData,Error>) in
            
            switch result {
            case .success(let success):
                let value = success.data.images
                self.galleryImagesItem = value
                guard let reloadCollection = self.reloadCollection else {return}
                reloadCollection()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    
    //MARK: - Datasource Fonksiyonları
    
    func getNumberOfRowsInSection() -> Int{
        guard let galleryImagesItem = galleryImagesItem else { return 0}
        return galleryImagesItem.count
    }
    
    func getCellForRowAt(indexpath: IndexPath) -> ImageItem? {
        guard let galleryImagesItem = galleryImagesItem else { return nil}
        let value = galleryImagesItem[indexpath.row]
        return value
    }
}

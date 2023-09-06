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
    
    var placeId:String?
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var galleryImagesItem: [ImageItem]?
    
    func getTravelItemByID (callback: @escaping (Place)->Void) {
        guard let placeId = placeId else { return }
        apiService.makeRequest(urlConvertible: Router.travelID(placeId: placeId)) { (result:Result<PlaceData,Error>) in
            switch result {
            case .success(let data):
                callback(data.data.place)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getGalleryItems(callback: @escaping () -> Void) {
        guard let placeId = placeId else { return }
        apiService.makeRequest(urlConvertible: Router.galleryID(placeId: placeId)) { (result:Result<GalleryData,Error>) in
            switch result {
            case .success(let success):
                let value = success.data.images
                self.galleryImagesItem = value
                callback()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func deleteVisitItem(callback: @escaping ()->Void) {
        guard let placeId = placeId else { return }
        DispatchQueue.global().async {
            self.apiService.makeRequest(urlConvertible: Router.deletePlace(placeId: placeId)) { (result:Result<DeleteVisitResponse,Error>) in
                switch result {
                case .success(let success):
                    if success.status == "success"{
                        DispatchQueue.main.async {
                            callback()
                        }
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func checkVisit(callback: @escaping (Bool)->Void) {
        guard let placeId = placeId else { return }

        DispatchQueue.global().async {
            self.apiService.makeRequest(urlConvertible: Router.deletePlace(placeId: placeId)) { (result:Result<CheckVisitResponse,Error>) in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        if success.message == true {
                            callback(true)
                        } else {
                            callback(false)
                        }
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
        
    }
    
    
    //MARK: - Datasource Fonksiyonları
    func getNumberOfRowsInSection() -> Int{
        guard let galleryImagesItem = galleryImagesItem else { return 0 }
        return galleryImagesItem.count
    }
    
    func getCellForRowAt(indexpath: IndexPath) -> ImageItem? {
        guard let galleryImagesItem = galleryImagesItem else { return nil }
        let value = galleryImagesItem[indexpath.row]
        return value
    }
    
}

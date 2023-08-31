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
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    var galleryImagesItem: [ImageItem]?
    
    var fillDetails: ((PlaceItem)->())?
    
    func getTravelItemByID (id:String, callback: @escaping (PlaceItem)->Void) {
        apiService.makeRequest(urlConvertible: Router.travelID(id: id)) { (result:Result<TravelID,Error>) in
            switch result {
            case .success(let success):
                let place = success.data.place
                callback(place)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getGalleryItems(id:String, callback: @escaping () -> Void) {
        apiService.makeRequest(urlConvertible: Router.galleryID(id: id)) { (result:Result<GalleryData,Error>) in
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
    
    func deleteVisitItem(visitId:String, callback: @escaping ()->Void) {
        apiService.makeRequest(urlConvertible: Router.deletePlace(visitId: visitId)) { (result:Result<DeleteVisitResponse,Error>) in
            switch result {
            case .success(let success):
                if success.status == "success"{
                    callback()
                }
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

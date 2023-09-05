//
//  Router.swift
//  AccessTokenApi
//
//  Created by Kullanici on 29.08.2023.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    //Auth
    case register(params:Parameters)
    case login(params:Parameters)
    case changePassword(params:Parameters)
    case editProfile(params:Parameters)
    case me
    //Travel
    case upload(image: [Data])
    case myAllVisits
    case travelID (placeId:String)
    case postPlace(params:Parameters)
    case deletePlace(visitId:String)
    // gallery Map
    case galleryID(placeId:String)
    case places
    case postGallery(params:Parameters)
    // seeAllPlaces
    case getPopularPlaces
    case getMyAddedPlaces
    case getLastPlaces
    
    //change-password
    var baseURL: URL {
           return URL(string: "https://api.iosclass.live/")!
       }
    
    var path: String {
        switch self {
        case .register:
            return  "v1/auth/register"
        case .login:
            return  "v1/auth/login"
        case .me:
            return  "v1/me"
        case .upload:
            return  "upload"
        case .myAllVisits:
            return  "v1/visits"
        case .travelID(let id):
            return  "v1/places/" + "\(id)"
        case .galleryID(let id):
            return "v1/galleries/" + "\(id)"
        case .places:
            return  "v1/places"
        case .deletePlace(let visitId):
            return "v1/visits" + "/\(visitId)"
        case .postPlace:
            return  "v1/places"
        case .postGallery(let params):
            return "v1/galleries"
        case .changePassword(let params):
            return "v1/change-password"
        case .editProfile(let params):
            return "v1/edit-profile"
        case .getPopularPlaces:
            return "v1/places/popular"
        case .getMyAddedPlaces:
            return "v1/places/user"
        case .getLastPlaces:
            return "v1/places/last"
        }
    }
    // query parametreler sorgu yapar.
    var method: HTTPMethod {
          switch self {
          case .login, .register, .upload,.postPlace, .postGallery :
              return .post
          case .me,.myAllVisits,.places,.travelID, .galleryID, .getPopularPlaces, .getMyAddedPlaces , .getLastPlaces :
              return .get
          case .deletePlace:
              return .delete
          case .changePassword, .editProfile:
              return .put
          }
      }
    
    var parameters: Parameters {
            switch self {
            case .login(let params), .register(let params), .postPlace(let params), .postGallery(let params), .editProfile(let params), .changePassword(let params):
                return params
            default:
                return [:]
            }
        }
    
    var headers: HTTPHeaders {
        switch self {
        case .login, .register, .getPopularPlaces, .getLastPlaces:
            return [:]
        case .upload:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Authorization": "Basic \(getTokenFromChain())",
            "Accept": "application/json"]
        }
    }
    
    var multipartFormData: MultipartFormData {
        let formData = MultipartFormData()
        switch self {
        
        case .upload(let imagedata):
            imagedata.forEach { image in
                formData.append(image, withName: "file", fileName: "image.jpg",
                                mimeType: "image/jpeg")
            }
            return formData
        default:
            break
        }
        return formData
    }
    
    func getTokenFromChain()->String {
        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
        return tokenstr
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
       
        
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(request, with: parameters)
    }
    
    
}

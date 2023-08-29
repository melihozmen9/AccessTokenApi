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
    case me
    //Travel
    case upload
    case myAllVisits
    case travelID (id:String)
    case postPlace(params:Parameters)
    // gallery Map
    case galleryID(id:String)
    case places
    case postGallery(params:Parameters)
    
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
            return  "v1/upload"
        case .myAllVisits:
            return  "v1/visits"
        case .travelID(let id):
            return  "v1/places/" + "\(id)"
        case .galleryID(let id):
            return "v1/galleries/" + "\(id)"
        case .places:
            return  "v1/places"
        case .postPlace:
            return  "v1/places"
        case .postGallery(params: let params):
            return "v1/galleries"
        }
    }
    // query parametreler sorgu yapar.
    var method: HTTPMethod {
          switch self {
          case .login, .register, .upload,.postPlace, .postGallery :
              return .post
          case .me,.myAllVisits,.places,.travelID, .galleryID :
              return .get
          }
      }
    
    var parameters: Parameters {
            switch self {
            case .login(let params), .register(let params), .postPlace(let params), .postGallery(let params):
                return params
            default:
                return [:]
            }
        }
    
    var headers: HTTPHeaders {
        switch self {
        case .login,.register:
            return [:]
        default:
            return ["Authorization": "Basic \(getTokenFromChain())",
            "Accept": "application/json"]
        }
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

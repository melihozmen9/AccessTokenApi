//
//  Enums.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//
//300 -> regular
//400 -> medium
//500 -> semibold
//600 -> bold
//Regular -> 400
//Medium -> 500
//SemiBold -> 600
//Bold -> 700

import UIKit
import Alamofire


//enum Router: URLRequestConvertible {
//    //Auth
//    case register(params:Parameters)
//    case login(params:Parameters)
//    case me
//    //Travel
//    case upload
//    case myAllVisits
//    case travelID (placeId:String)
//    case postPlace(params:Parameters)
//    case deletePlace(visitId:String)
//    case isTraveled(placeId:String)
//    // gallery Map
//    case galleryID(placeId:String)
//    case places
//
//    var baseURL: URL {
//           return URL(string: "https://api.iosclass.live/")!
//       }
//
//    var path: String {
//        switch self {
//        case .register:
//            return  "v1/auth/register"
//        case .login:
//            return  "v1/auth/login"
//        case .me:
//            return  "v1/me"
//        case .upload:
//            return  "v1/upload"
//        case .myAllVisits:
//            return  "v1/visits"
//        case .travelID(let placeId):
//            return  "v1/places/" + "\(placeId)"
//        case .galleryID(let id):
//            return "v1/galleries/" + "\(id)"
//        case .places:
//            return  "v1/places"
//        case .postPlace:
//            return  "v1/places"
//        case .deletePlace(let visitId):
//            return "v1/visits" + "/\(visitId)"
//        case .isTraveled(let placeId):
//            return "v1/visits/user" + "\(placeId)"
//        }
//    }
//    // query parametreler sorgu yapar.
//    var method: HTTPMethod {
//          switch self {
//          case .login, .register, .upload,.postPlace :
//              return .post
//          case .me,.myAllVisits,.places,.travelID, .galleryID, .isTraveled :
//              return .get
//          case .deletePlace:
//              return .delete
//          }
//      }
//
//    var parameters: Parameters {
//            switch self {
//            case .login(let params), .register(let params), .postPlace(let params):
//                return params
//            default:
//                return [:]
//            }
//        }
//
//    var headers: HTTPHeaders {
//        switch self {
//        case .login,.register, .isTraveled:
//            return [:]
//        default:
//            return ["Authorization": "Bearer \(getTokenFromChain())"]
//        }
//    }
//
//    func getTokenFromChain()->String {
//        guard let token = KeychainHelper.shared.read(service: "access-token", account: "api.Iosclass") else {return""}
//        guard let tokenstr = String(data: token, encoding: .utf8) else {return""}
//        return tokenstr
//    }
//
//
//
//    func asURLRequest() throws -> URLRequest {
//
//
//        let url = baseURL.appendingPathComponent(path)
//        var request = URLRequest(url: url)
//        request.method = method
//        request.headers = headers
//
//        let encoding: ParameterEncoding = {
//            switch method {
//            case .get:
//                return URLEncoding.default
//            default:
//                return JSONEncoding.default
//            }
//        }()
//
//        return try encoding.encode(request, with: parameters)
//    }
//    
//
//}

enum Font {
    case regular12
    case regular14
    case regular16
    case semibold32
    case semibold24
    case semibold20
    case semibold16
    case semibold14
    case semibold12
    case bold36
    case bold32
    case bold30
    case bold24
    case bold16
    case bold14
    case medium14
    var chooseFont: UIFont {
        switch self {
        case .regular12:
            return UIFont(name: "Poppins-Regular", size: 12)!
        case .regular14:
            return UIFont(name: "Poppins-Regular", size: 14)!
        case .regular16:
            return UIFont(name: "Poppins-Regular", size: 16)!
        case .bold14:
            return UIFont(name: "Poppins-Bold", size: 14)!
        case .semibold32:
            return UIFont(name: "Poppins-SemiBold", size: 32)!
        case .semibold24:
            return UIFont(name: "Poppins-SemiBold", size: 24)!
        case .semibold20:
            return UIFont(name: "Poppins-SemiBold", size: 20)!
        case .semibold16:
            return UIFont(name: "Poppins-SemiBold", size: 16)!
        case .semibold14:
            return UIFont(name: "Poppins-SemiBold", size: 14)!
        case .semibold12:
            return UIFont(name: "Poppins-SemiBold", size: 12)!
        case .bold36:
            return UIFont(name: "Poppins-Bold", size: 36)!
        case .bold30:
            return UIFont(name: "Poppins-Bold", size: 30)!
        case .medium14:
            return UIFont(name: "Poppins-Medium", size: 14)!
        case .bold24:
            return UIFont(name: "Poppins-Bold", size: 24)!
        case .bold16:
            return UIFont(name: "Poppins-Bold", size: 16)!
        case .bold32:
            return UIFont(name: "Poppins-Bold", size: 32)!
        
        }
    }
}

enum Color {
    case systemGreen
    case systemblack
    case systemWhite
    case systemBlue
    case white
    case systemgray
    case barItemColor
    
    var chooseColor: UIColor {
        switch self {
        case .systemGreen:
            return #colorLiteral(red: 0.2196078431, green: 0.6784313725, blue: 0.662745098, alpha: 1)
        case .systemblack:
            return #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        case .systemWhite:
            return #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .systemgray:
            return #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        case .barItemColor:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        case .systemBlue:
            return #colorLiteral(red: 0.09019607843, green: 0.7529411765, blue: 0.9215686275, alpha: 1)
        }
    }
}


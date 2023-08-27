//
//  TravelID.swift
//  AccessTokenApi
//
//  Created by Kullanici on 21.08.2023.
//

import Foundation

struct TravelID: Codable {
    var data: SingleTravel
    var status: String
}
struct SingleTravel : Codable {
    var place: PlaceItem
}

//{
//    "data": {
//        "place": {
//            "id": "5ee3e518-39e5-47b6-a18a-e942a5598aae",
//            "creator": "Melihozm",
//            "place": "Adıyaman, Türkiye",
//            "title": "Nemrut Dağı Milli Parkı",
//            "description": "2150 m. Yüksekliğine sahip Dağ sadece ülkemiz için değil tüm dünya için eşsiz bir kültür mirasıdır. İşte tam da bu sebepten dolayı UNESCO’da Nemrut Dağı’na ilgisiz kalmamış dünya kültür mirası listesine almıştır. Yani dünyanın sekizinci harikası olarak nitelendirilen Nemrut heykeli bu listeye eklenmesinin en önemli nedeni. Heykel’in yanında bir de kitabe bulunmaktadır.Kitabeler ile birlikte anıt mezarları da vardır.",
//            "cover_image_url": "https://live.staticflickr.com/2941/15102053140_69e59cc770_b.jpg",
//            "latitude": 37.980927,
//            "longitude": 38.74131,
//            "created_at": "2023-08-24T08:54:08.329671Z",
//            "updated_at": "2023-08-24T08:54:08.329671Z"
//        }
//    },
//    "status": "success"
//}

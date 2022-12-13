//
//  NetworkHelper.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation

enum NetworkEndPoint: String {
    case BASE_URL = "https://yummie.glitch.me"
    
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    func requestUrl(url:String) -> String {
        return "\(NetworkEndPoint.BASE_URL.rawValue)\(url)"
    }
}

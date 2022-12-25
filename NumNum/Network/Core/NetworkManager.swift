//
//  NetworkManager.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation
import Alamofire


class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T>(path: String, onSuccess: @escaping (T) -> (), onError: (AFError) -> ()) where T:Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let model = response.value else { print(response.error as Any); return }
            onSuccess(model)
            
            
        }
    }
    
}


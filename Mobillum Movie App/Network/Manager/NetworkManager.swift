//
//  NetworkManager.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import Foundation

import Alamofire

final class NetworkManager {

    public static let shared: NetworkManager = NetworkManager()
}

extension NetworkManager {
    
    func fetch<T>(path: String, onSuccess: @escaping (T) -> Void, onError: @escaping (AFError) -> Void) where T: Codable {
        
        AF.request(path,encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { (response) in
            guard let model = response.value else {
                return
            }
            onSuccess(model)
        }
    }
}

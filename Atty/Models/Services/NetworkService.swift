//
//  NetworkService.swift
//  Atty
//
//  Created by Nikita Melnikov on 13.11.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

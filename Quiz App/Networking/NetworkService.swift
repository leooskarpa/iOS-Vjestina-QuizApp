//
//  NetworkService.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.05.2021..
//

import Foundation
import UIKit


class NetworkService {
    func executeUrlRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping(Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in

            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.dataEncodingError))
                return
            }
            
            completionHandler(.success(value))
            
        }
        dataTask.resume()
    }
}


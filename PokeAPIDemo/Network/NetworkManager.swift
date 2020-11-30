//
//  NetworkManager.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation
import UIKit

final class NetworkManager {
    
    enum NetworkError: Error {
        case notFound
        case failed
        case noData
        case other
    }
    
    static let shared = NetworkManager()
    
    func getNetworkData(from urlString: String, completion: @escaping (Result<Pokemon, Error>) -> () ) {
        
        guard let url = URL(string: urlString) else { fatalError("Unable to create url from String in Network Manager closing statement.") }
        let request = URLRequest(url:url)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let err = error {
                completion(.failure(err))
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 404:
                    completion(.failure(NetworkError.notFound))
                case 200:
                    if data != nil {
                        if let data = data {
                            do {
                                let jsonDecoder = JSONDecoder()
                                let responseModel = try jsonDecoder.decode(Pokemon.self, from: data)
                                
                                
                                
                                completion(.success(responseModel))
                            } catch {
                                completion(.failure(error))
                            }
                        } else {
                            completion(.failure(NetworkError.noData))
                        }
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                default:
                    completion(.failure(NetworkError.other))
                }
            }
        }.resume()

        
    }
    
    
    
    
    
}

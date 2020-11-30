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
        
        
        let username = "trekkadmin"
        let password = "p*Q3Ns7QPXhfWia#Hg"
        
        let url = URL(string: urlString)!
        let request = URLRequest(url:url)

        let config = URLSessionConfiguration.default
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
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

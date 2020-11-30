//
//  ProtocolNetworkManager.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

protocol ProtocolNetworkManagerDelegate {
    func getNetworkData(data: Pokemon)
}

final class ProtocolNetworkManager {
    
    var delegate:ProtocolNetworkManagerDelegate?
    
    enum NetworkError: Error {
        case notFound
        case failed
        case noData
        case other
    }
    
    
    func getNetworkData(from url: String) {
        
        guard let url = URL(string: url) else { fatalError("Unable to create url from String in Protocol Network Manager closing statement.") }
        let request = URLRequest(url:url)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let err = error {
                fatalError("Protocol Network Manager Error: \(err) ")
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 404:
//                    completion(.failure(NetworkError.notFound))
                fatalError("Unable to reach URL in Protocol Network Manager.")
                case 200:
                    if data != nil {
                        if let data = data {
                            do {
                                let jsonDecoder = JSONDecoder()
                                let responseModel = try jsonDecoder.decode(Pokemon.self, from: data)
                                self.delegate?.getNetworkData(data: responseModel)
                            } catch {
                                fatalError("Unable to reach URL in Protocol Network Manager.")
                            }
                        } else {
                            fatalError("Unable to reach URL in Protocol Network Manager.")
                        }
                    } else {
                        fatalError("Unable to reach URL in Protocol Network Manager.")
                    }
                default:
                    fatalError("Unable to reach URL in Protocol Network Manager.")
                
                }
            }
        }.resume()

        
        
    }
    
}


//
//  ProtocolNetworkManager.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

protocol NetworkManagerDelegate {
    func getNetworkData(data: Pokemon)
}

final class ProtocolNetworkManager {
    
    enum NetworkError: Error {
        case notFound
        case failed
        case noData
        case other
    }
    
    
    func getNetworkData(from url: String) {
        
    }
    
}


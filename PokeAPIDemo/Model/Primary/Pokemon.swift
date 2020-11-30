//
//  File.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

struct Pokemon : Codable {

        let count : Int?
        let results : [SinglePokemon]?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case results = "results"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                count = try values.decodeIfPresent(Int.self, forKey: .count)
                results = try values.decodeIfPresent([SinglePokemon].self, forKey: .results)
        }

}


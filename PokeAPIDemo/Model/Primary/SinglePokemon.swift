//
//  Result.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

struct SinglePokemon : Codable {

        let name : String?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case name = "name"
                case url = "url"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                url = try values.decodeIfPresent(String.self, forKey: .url)
        }

}

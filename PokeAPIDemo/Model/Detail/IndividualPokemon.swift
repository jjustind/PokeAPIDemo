//
//  IndividualPokemon.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

struct IndividualPokemon : Codable {
        let height : Int?
        let id : Int?
        let isDefault : Bool?
        let locationAreaEncounters : String?
        let name : String?
        let weight : Int?

        enum CodingKeys: String, CodingKey {
                case height = "height"
                case id = "id"
                case isDefault = "is_default"
                case locationAreaEncounters = "location_area_encounters"
                case name = "name"
                case weight = "weight"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                height = try values.decodeIfPresent(Int.self, forKey: .height)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)
                locationAreaEncounters = try values.decodeIfPresent(String.self, forKey: .locationAreaEncounters)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                weight = try values.decodeIfPresent(Int.self, forKey: .weight)
        }

}

//
//  Ability.swift
//  PokeAPIDemo
//
//  Created by Justin Davis on 11/28/20.
//

import Foundation

struct Move : Codable {

        let move : Move?
        let versionGroupDetails : [VersionGroupDetail]?

        enum CodingKeys: String, CodingKey {
                case move = "move"
                case versionGroupDetails = "version_group_details"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                move = Move(from: decoder)
                versionGroupDetails = try values.decodeIfPresent([VersionGroupDetail].self, forKey: .versionGroupDetails)
        }

}





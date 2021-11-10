//
//  Oracles.swift
//  
//
//  Created by Quinn McHenry on 11/9/21.
//

//{
//  "Title": "Ironsworn Character Oracles",
//  "Oracles": [
//    {
//      "Name": "Role",
//      "Oracle Table": [
//        {
//          "Chance": 2,
//          "Description": "Criminal"
//        },
//        {
//          "Chance": 4,
//          "Description": "Healer"
//        },

import Foundation

public struct OracleFile: Codable, Identifiable {
    public let title: String
    public let oracles: [Oracle]
    public var id: String { title }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case oracles = "Oracles"
    }
}

public struct Oracle: Codable, Identifiable {
    public let name: String
    public let table: [OracleItem]
    public var id: String { name }

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case table = "Oracle Table"
    }
}

public struct OracleItem: Codable {
    public let chance: Int
    public let description: String
    enum CodingKeys: String, CodingKey {
        case chance = "Chance"
        case description = "Description"
    }
}

public struct Oracles {

    public static func load(oracleFile file: String) -> OracleFile {
        guard let url = Bundle.module.url(forResource: file, withExtension: "json") else {
            print("url shmurl")
            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let oracle = try JSONDecoder().decode(OracleFile.self, from: data)
            return oracle
        } catch {
            print(error)
            fatalError()
        }
    }

    public static var all: [OracleFile] {
        [characters, monstrosity, names, place, settlement, threat, turningPoint]
    }

    public static var characters: OracleFile {
        load(oracleFile: "ironsworn_oracles_character")
    }

//    public static var delveSites: OracleFile {
//        load(oracleFile: "ironsworn_oracles_delve_sites")
//    }

    public static var monstrosity: OracleFile {
        load(oracleFile: "ironsworn_oracles_monstrosity")
    }

    public static var names: OracleFile {
        load(oracleFile: "ironsworn_oracles_names")
    }

    public static var place: OracleFile {
        load(oracleFile: "ironsworn_oracles_place")
    }

//    public static var prompts: OracleFile {
//        load(oracleFile: "ironsworn_oracles_prompts")
//    }

    public static var settlement: OracleFile {
        load(oracleFile: "ironsworn_oracles_settlement")
    }

    public static var threat: OracleFile {
        load(oracleFile: "ironsworn_oracles_threat")
    }

    public static var turningPoint: OracleFile {
        load(oracleFile: "ironsworn_oracles_turning_point")
    }

}

//
//  Oracles.swift
//  
//
//  Created by Quinn McHenry on 11/9/21.
//

// MARK: - autogenerated
// This section was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - OracleFile
public struct OracleFile: Codable, Identifiable {
    public let title: String
    public let oracles: [Oracle]
    public var id: String { title }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case oracles = "Oracles"
    }
}

// MARK: - Oracle
public struct Oracle: Codable, Identifiable {
    public let name: String
    public let oracleTable: [OracleTable]?
    public let oracles: [Oracle]?
    public var id: String { name }

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case oracleTable = "Oracle Table"
        case oracles = "Oracles"
    }
}

// MARK: - OracleTable
public struct OracleTable: Codable {
    public let chance: Int
    public let description: String
    public let prompt: String?
    public let oracleTable: [OracleTable]?

    enum CodingKeys: String, CodingKey {
        case chance = "Chance"
        case description = "Description"
        case prompt = "Prompt"
        case oracleTable = "Oracle Table"
    }
}


// MARK: -

extension Oracle {
    public var totalChance: Int {
        oracleTable?.map { $0.chance }.sorted().last ?? 0
    }

    public func roll() -> (Int, String) {
        guard totalChance > 0, let oracleTable = oracleTable else { return (0, "") }
        let roll = Int.random(in: 0..<totalChance)
        guard let answer = oracleTable.filter({ $0.chance < roll }).last else { return (roll, "shrug") }
        return (roll, answer.description)
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
        [characters, monstrosity, names, place, prompts, settlement, threat, turningPoint]
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

    public static var prompts: OracleFile {
        load(oracleFile: "ironsworn_oracles_prompts")
    }

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

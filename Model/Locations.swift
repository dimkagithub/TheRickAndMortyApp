//
//  Locations.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 03.10.2021.
//

import Foundation

struct Locations: Codable {
    let locationsInfo: LocationsInfo
    let locationsResults: [LocationsResults]
    
    enum CodingKeys: String, CodingKey {
        case locationsInfo = "info"
        case locationsResults = "results"
    }
}

struct LocationsInfo: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: LocationsJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}

struct LocationsResults: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case dimension = "dimension"
        case residents = "residents"
        case url = "url"
        case created = "created"
    }
}

class LocationsJSONNull: Codable, Hashable {
    
    public static func == (lhs: LocationsJSONNull, rhs: LocationsJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(LocationsJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

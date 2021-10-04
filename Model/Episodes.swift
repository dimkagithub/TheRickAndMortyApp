//
//  Episodes.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 03.10.2021.
//

import Foundation

struct Episodes: Codable {
    let episodesinfo: Episodesinfo
    let episodesResults: [EpisodesResults]
    
    enum CodingKeys: String, CodingKey {
        case episodesinfo = "info"
        case episodesResults = "results"
    }
}

struct Episodesinfo: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: EpisodesJSONNull?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}

struct EpisodesResults: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
        case url = "url"
        case created = "created"
    }
}

class EpisodesJSONNull: Codable, Hashable {
    
    public static func == (lhs: EpisodesJSONNull, rhs: EpisodesJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(EpisodesJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

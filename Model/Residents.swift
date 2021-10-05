//
//  Residents.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 05.10.2021.
//

import Foundation

struct Residents: Codable {
    let residentsId: Int
    let residentsName: String
    let residentsStatus: String
    let residentsSpecies: String
    let residentsType: String
    let residentsGender: String
    let residentsOrigin: ResidentsLocation
    let residentsLocation: ResidentsLocation
    let residentsImage: String
    let residentsEpisode: [String]
    let residentsUrl: String
    let residentsCreated: String
    
    enum CodingKeys: String, CodingKey {
        case residentsId = "id"
        case residentsName = "name"
        case residentsStatus = "status"
        case residentsSpecies = "species"
        case residentsType = "type"
        case residentsGender = "gender"
        case residentsOrigin = "origin"
        case residentsLocation = "location"
        case residentsImage = "image"
        case residentsEpisode = "episode"
        case residentsUrl = "url"
        case residentsCreated = "created"
    }
}

struct ResidentsLocation: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

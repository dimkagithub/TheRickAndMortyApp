//
//  Network.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 03.10.2021.
//

import UIKit

var allCharacters: Characters?
var allLocations: Locations?
var allEpisodes: Episodes?

func getCharacters(_ completion: @escaping() -> Void, JSONerrorAlertCallBack: @escaping() -> Void, serverErrorCallBack: @escaping() -> Void) {
    let urlString = "https://rickandmortyapi.com/api/character/?page="
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration)
    guard let url = URL(string: urlString) else {
        serverErrorCallBack()
        return
    }
    let task = session.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        guard error == nil else { return }
        do {
            allCharacters = try JSONDecoder().decode(Characters.self, from: data)
            
        } catch let error {
            print(error)
            JSONerrorAlertCallBack()
        }
        completion()
    }
    task.resume()
}

func getLocations(_ completion: @escaping() -> Void, JSONerrorAlertCallBack: @escaping() -> Void, serverErrorCallBack: @escaping() -> Void) {
    let urlString = "https://rickandmortyapi.com/api/location?page="
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration)
    guard let url = URL(string: urlString) else {
        serverErrorCallBack()
        return
    }
    let task = session.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        guard error == nil else { return }
        do {
            allLocations = try JSONDecoder().decode(Locations.self, from: data)
            
        } catch let error {
            print(error)
            JSONerrorAlertCallBack()
        }
        completion()
    }
    task.resume()
}

func getEpisodes(_ completion: @escaping() -> Void, JSONerrorAlertCallBack: @escaping() -> Void, serverErrorCallBack: @escaping() -> Void) {
    let urlString = "https://rickandmortyapi.com/api/episode?page="
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration)
    guard let url = URL(string: urlString) else {
        serverErrorCallBack()
        return
    }
    let task = session.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        guard error == nil else { return }
        do {
            allEpisodes = try JSONDecoder().decode(Episodes.self, from: data)
            
        } catch let error {
            print(error)
            JSONerrorAlertCallBack()
        }
        completion()
    }
    task.resume()
}

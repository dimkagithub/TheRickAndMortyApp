//
//  NumberOfCharacters.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 05.10.2021.
//

import UIKit

class NumberOfCharactersTVC: UITableViewController {
    
    var characters: EpisodeCharacters?
    var charactersEpisodes: Episode?
    var characterEpisode = [String]()
    var charactersInfo = [String]()
    var name = [String]()
    var image = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nOcharactersViewCell", for: indexPath) as! NumberOfCharactersTVCell
        let urlString = charactersInfo[indexPath.row]
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                self.characters = try JSONDecoder().decode(EpisodeCharacters.self, from: data)
                DispatchQueue.main.async {
                    cell.nOcharactersImage.downloadImageFrom(link: self.characters!.image)
                    cell.nOcharactersName.text = self.characters?.name
                    if self.characters?.status == "Alive" {
                        cell.nOcharactersStatusImage.backgroundColor = .green
                    } else if self.characters?.status == "Dead" {
                        cell.nOcharactersStatusImage.backgroundColor = .red
                    } else {
                        cell.nOcharactersStatusImage.backgroundColor = .lightGray
                    }
                    cell.nOcharactersStatusText.text = ("\(self.characters!.status) - \(self.characters!.species) - \(self.characters!.gender)")
                    cell.nOcharactersLocation.text = self.characters!.location.name
                    self.characterEpisode.append((self.characters?.episode[0])!)
                    for index in 0..<self.characterEpisode.count {
                        let urlString = self.characterEpisode[index]
                        let configuration = URLSessionConfiguration.ephemeral
                        let session = URLSession(configuration: configuration)
                        let url = URL(string: urlString)
                        let task = session.dataTask(with: url!) { (data, response, error) in
                            guard let data = data else { return }
                            guard error == nil else { return }
                            do {
                                self.charactersEpisodes = try JSONDecoder().decode(Episode.self, from: data)
                                DispatchQueue.main.async {
                                    cell.nOcharactersEpisode.text = self.charactersEpisodes?.name
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                        task.resume()
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
        return cell
    }
}

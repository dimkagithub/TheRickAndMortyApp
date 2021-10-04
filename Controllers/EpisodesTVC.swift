//
//  EpisodesTVC.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class EpisodesTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodes?.episodesResults.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodesViewCell", for: indexPath) as! EpisodesTVCell
        cell.episodesNameInfo.text = allEpisodes?.episodesResults[indexPath.row].name
        cell.episodesAirDateInfo.text = allEpisodes?.episodesResults[indexPath.row].airDate
        cell.episodesCodeOfEpisodeInfo.text = allEpisodes?.episodesResults[indexPath.row].episode
        cell.episodesNoCInfo.text = allEpisodes?.episodesResults[indexPath.row].characters.count.description
        return cell
    }
}

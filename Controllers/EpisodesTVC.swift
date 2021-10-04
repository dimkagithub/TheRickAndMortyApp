//
//  EpisodesTVC.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class EpisodesTVC: UITableViewController {
    
    var filteredEpisodes = [EpisodesResults]()
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var filtering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск..."
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtering {
            return filteredEpisodes.count
        } else {
            return allEpisodes?.episodesResults.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodesViewCell", for: indexPath) as! EpisodesTVCell
        var episodes: [EpisodesResults]
        if filtering {
            episodes = filteredEpisodes
        } else {
            episodes = allEpisodes!.episodesResults
        }
        cell.episodesNameInfo.text = episodes[indexPath.row].name
        cell.episodesAirDateInfo.text = episodes[indexPath.row].airDate
        cell.episodesCodeOfEpisodeInfo.text = episodes[indexPath.row].episode
        cell.episodesNoCInfo.text = episodes[indexPath.row].characters.count.description
        return cell
    }
}

extension EpisodesTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if let searchText = searchController.searchBar.text {
            let searchText = searchText.lowercased()
            filteredEpisodes = (allEpisodes?.episodesResults.filter({ $0.name.lowercased().range(of: searchText.lowercased()) != nil}))!
            filteredEpisodes += (allEpisodes?.episodesResults.filter({ $0.airDate.lowercased().range(of: searchText.lowercased()) != nil}))!
            filteredEpisodes += (allEpisodes?.episodesResults.filter({ $0.episode.lowercased().range(of: searchText.lowercased()) != nil}))!
            tableView.reloadData()
        }
    }
}

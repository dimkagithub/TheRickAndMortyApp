//
//  CharactersTVC.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 03.10.2021.
//

import UIKit
import SystemConfiguration

class CharactersTVC: UITableViewController {
    
    var episode: Episode?
    var filteredCharacters = [CharactersResults]()
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var filtering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func showNoInternetAlert() {
        if !isInternetAvailable() {
            let alert = UIAlertController(title: "Нет соединения с интернет", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func showJSONerrorAlert() {
        let alert = UIAlertController(title: "Ошибка обработки данных", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showServerErrorAlert() {
        let alert = UIAlertController(title: "Сервер недоступен", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск..."
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        definesPresentationContext = true
        getCharacters {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } JSONerrorAlertCallBack: {
            DispatchQueue.main.async {
                self.showJSONerrorAlert()
            }
        } serverErrorCallBack: {
            DispatchQueue.main.async {
                self.showServerErrorAlert()
            }
        }
        getLocations {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } JSONerrorAlertCallBack: {
            DispatchQueue.main.async {
                self.showJSONerrorAlert()
            }
        } serverErrorCallBack: {
            DispatchQueue.main.async {
                self.showServerErrorAlert()
            }
        }
        getEpisodes {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } JSONerrorAlertCallBack: {
            DispatchQueue.main.async {
                self.showJSONerrorAlert()
            }
        } serverErrorCallBack: {
            DispatchQueue.main.async {
                self.showServerErrorAlert()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtering {
            return filteredCharacters.count
        } else {
            return allCharacters?.charactersResults.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersViewCell", for: indexPath) as! CharactersTVCell
        var characters: [CharactersResults]
        if filtering {
            characters = filteredCharacters
        } else {
            characters = allCharacters!.charactersResults
        }
        cell.characterImage.downloadImageFrom(link: (characters[indexPath.row].image))
        cell.characterName.text = characters[indexPath.row].name
        if characters[indexPath.row].status.rawValue == "Alive" {
            cell.characterStatusImage.backgroundColor = .green
        } else if characters[indexPath.row].status.rawValue == "Dead" {
            cell.characterStatusImage.backgroundColor = .red
        } else {
            cell.characterStatusImage.backgroundColor = .lightGray
        }
        cell.characterStatusText.text = ("\(characters[indexPath.row].status.rawValue) - \(characters[indexPath.row].species.rawValue) -  \(characters[indexPath.row].gender.rawValue)")
        cell.characterLocation.text = characters[indexPath.row].location.name
        let urlString = characters[indexPath.row].episode[0]
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                self.episode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    cell.characterEpisode.text = self.episode?.name
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllCharacterInfo" {
            let controller = segue.destination as! FirstViewController
            if let index = tableView.indexPathForSelectedRow {
                var characters: [CharactersResults]
                if filtering {
                    characters = filteredCharacters
                } else {
                    characters = allCharacters!.charactersResults
                }
                controller.fvcImage = characters[index.row].image
                controller.characterInfo.append(contentsOf: [String(characters[index.row].name)])
                controller.characterInfo.append(contentsOf: [String(characters[index.row].status.rawValue)])
                controller.characterInfo.append(contentsOf:[String(characters[index.row].species.rawValue)])
                if characters[index.row].type == "" {
                    controller.characterInfo.append(contentsOf:[String("—")])
                } else {
                    controller.characterInfo.append(contentsOf: [String(characters[index.row].type)])
                }
                controller.characterInfo.append(contentsOf:[String(characters[index.row].gender.rawValue)])
                controller.characterInfo.append(contentsOf:[String(characters[index.row].origin.name)])
                controller.characterInfo.append(contentsOf:[String(characters[index.row].location.name)])
                controller.characterInfo.append(contentsOf:[String(characters[index.row].episode.count)])
            }
        }
    }
}

extension CharactersTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = (allCharacters?.charactersResults.filter ({ (allCharacters: CharactersResults) -> Bool in
            return allCharacters.name.lowercased().contains(searchText.lowercased())
        }))!
        tableView.reloadData()
    }
}

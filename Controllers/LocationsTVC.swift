//
//  LocationTVC.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class LocationsTVC: UITableViewController {
    
    var filteredLocations = [LocationsResults]()
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
            return filteredLocations.count
        } else {
            return allLocations?.locationsResults.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationsViewCell", for: indexPath) as! LocationsTVCell
        var locations: [LocationsResults]
        if filtering {
            locations = filteredLocations
        } else {
            locations = allLocations!.locationsResults
        }
        cell.locationNameInfo.text = locations[indexPath.row].name
        cell.locationTypeInfo.text = locations[indexPath.row].type
        cell.locationDimensionInfo.text = locations[indexPath.row].dimension
        cell.locationNoRinfo.text = locations[indexPath.row].residents.count.description
        return cell
    }
}

extension LocationsTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if let searchText = searchController.searchBar.text {
            let searchText = searchText.lowercased()
            filteredLocations = (allLocations?.locationsResults.filter({ $0.name.lowercased().range(of: searchText.lowercased()) != nil}))!
            filteredLocations += (allLocations?.locationsResults.filter({ $0.type.lowercased().range(of: searchText.lowercased()) != nil}))!
            filteredLocations += (allLocations?.locationsResults.filter({ $0.dimension.lowercased().range(of: searchText.lowercased()) != nil}))!
            tableView.reloadData()
        }
    }
}

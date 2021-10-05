//
//  ResidentsTVC.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 05.10.2021.
//

import UIKit

class ResidentsTVC: UITableViewController {
    
    var residents: Residents?
    var residentEpisodes: Episode?
    var residentEpisode = [String]()
    var residentsInfo = [String]()
    var name = [String]()
    var image = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "residentsViewCell", for: indexPath) as! ResidentsTVCell
        let urlString = residentsInfo[indexPath.row]
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                self.residents = try JSONDecoder().decode(Residents.self, from: data)
                DispatchQueue.main.async {
                    cell.residentImage.downloadImageFrom(link: self.residents!.residentsImage)
                    cell.residentName.text = self.residents?.residentsName
                    if self.residents?.residentsStatus == "Alive" {
                        cell.residentStatusImage.backgroundColor = .green
                    } else if self.residents?.residentsStatus == "Dead" {
                        cell.residentStatusImage.backgroundColor = .red
                    } else {
                        cell.residentStatusImage.backgroundColor = .lightGray
                    }
                    cell.residentStatusText.text = ("\(self.residents!.residentsStatus) - \(self.residents!.residentsSpecies) - \(self.residents!.residentsGender)")
                    cell.residentLocation.text = self.residents?.residentsLocation.name
                    self.residentEpisode.append((self.residents?.residentsEpisode[0])!)
                    for index in 0..<self.residentEpisode.count {
                        let urlString = self.residentEpisode[index]
                        let configuration = URLSessionConfiguration.ephemeral
                        let session = URLSession(configuration: configuration)
                        let url = URL(string: urlString)
                        let task = session.dataTask(with: url!) { (data, response, error) in
                            guard let data = data else { return }
                            guard error == nil else { return }
                            do {
                                self.residentEpisodes = try JSONDecoder().decode(Episode.self, from: data)
                                DispatchQueue.main.async {
                                    cell.residentEpisode.text = self.residentEpisodes?.name
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

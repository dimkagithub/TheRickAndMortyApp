//
//  FirstViewController.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var charachterAllView: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var ftvcTableView: UITableView!
    
    var characterInfo = [String]()
    var fvcImage = String()
    var characterTitle = [
        "Name",
        "Status",
        "Species",
        "Type",
        "Gender",
        "Origin",
        "Last known location",
        "Number of episodes"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ftvcTableView.delegate = self
        ftvcTableView.dataSource = self
        setUpView()
        characterImage.downloadImageFrom(link: fvcImage)
    }
    
    private func setUpView() {
        charachterAllView.roundCorners(corners: .allCorners, radius: 10)
        characterImage.roundCorners(corners: .allCorners, radius: 10)
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ftvcTableView.dequeueReusableCell(withIdentifier: "ftvcViewCell") as! FVCViewCell
        cell.characterTitle.text = characterTitle[indexPath.row]
        cell.characterInfo.text = characterInfo[indexPath.row]
        return cell
    }
}

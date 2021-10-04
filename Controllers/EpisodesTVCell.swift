//
//  EpisodesTVCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class EpisodesTVCell: UITableViewCell {
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var episodesNameInfo: UILabel!
    @IBOutlet weak var episodesAirDateInfo: UILabel!
    @IBOutlet weak var episodesCodeOfEpisodeInfo: UILabel!
    @IBOutlet weak var episodesNoCInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        episodesView.roundCorners(corners: .allCorners, radius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

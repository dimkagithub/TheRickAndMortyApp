//
//  CharactersTVCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 03.10.2021.
//

import UIKit

class CharactersTVCell: UITableViewCell {
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterLocation: UILabel!
    @IBOutlet weak var characterEpisode: UILabel!
    @IBOutlet weak var characterStatusImage: UIImageView!
    @IBOutlet weak var characterStatusText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        characterView.roundCorners(corners: .allCorners, radius: 10)
        characterStatusImage.roundCorners(corners: .allCorners, radius: 4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

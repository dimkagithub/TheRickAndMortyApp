//
//  NumberOfCaractersCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 05.10.2021.
//

import UIKit

class NumberOfCharactersTVCell: UITableViewCell {
    
    @IBOutlet weak var nOcharactersView: UIView!
    @IBOutlet weak var nOcharactersImage: UIImageView!
    @IBOutlet weak var nOcharactersName: UILabel!
    @IBOutlet weak var nOcharactersStatusImage: UIImageView!
    @IBOutlet weak var nOcharactersStatusText: UILabel!
    @IBOutlet weak var nOcharactersLocation: UILabel!
    @IBOutlet weak var nOcharactersEpisode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        nOcharactersView.roundCorners(corners: .allCorners, radius: 10)
        nOcharactersStatusImage.roundCorners(corners: .allCorners, radius: 4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

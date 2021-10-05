//
//  ResidentsTVCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 05.10.2021.
//

import UIKit

class ResidentsTVCell: UITableViewCell {
    @IBOutlet weak var residentView: UIView!
    @IBOutlet weak var residentImage: UIImageView!
    @IBOutlet weak var residentName: UILabel!
    @IBOutlet weak var residentStatusImage: UIImageView!
    @IBOutlet weak var residentStatusText: UILabel!
    @IBOutlet weak var residentLocation: UILabel!
    @IBOutlet weak var residentEpisode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        residentView.roundCorners(corners: .allCorners, radius: 10)
        residentStatusImage.roundCorners(corners: .allCorners, radius: 4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

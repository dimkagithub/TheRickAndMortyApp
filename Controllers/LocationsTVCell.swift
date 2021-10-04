//
//  LocationTVCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class LocationsTVCell: UITableViewCell {
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationNameInfo: UILabel!
    @IBOutlet weak var locationTypeInfo: UILabel!
    @IBOutlet weak var locationDimensionInfo: UILabel!    
    @IBOutlet weak var locationNoRinfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        locationView.roundCorners(corners: .allCorners, radius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

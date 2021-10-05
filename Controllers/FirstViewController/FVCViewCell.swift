//
//  FVCViewCell.swift
//  TheRickAndMortyApp
//
//  Created by Дмитрий on 04.10.2021.
//

import UIKit

class FVCViewCell: UITableViewCell {
    @IBOutlet weak var ftvcView: UIView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var characterInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        ftvcView.roundCorners(corners: .allCorners, radius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

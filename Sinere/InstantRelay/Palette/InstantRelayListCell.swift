//
//  InstantRelayListCell.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit

class InstantRelayListCell: UITableViewCell {
    
    @IBOutlet weak var senUserImagePalette: UIImageView!
    @IBOutlet weak var sneUserNamepalettr: UILabel!
    @IBOutlet weak var sneInstantRelay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = UIColor.init(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: 0.5).cgColor
        self.layer.borderWidth = 1
    }
}

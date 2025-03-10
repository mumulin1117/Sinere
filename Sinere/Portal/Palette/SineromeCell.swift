//
//  SineromeCell.swift
//  Sinere
//
//  Created by Sinere on 2025/3/7.
//

import UIKit

class SineromeCell: UICollectionViewCell {

    @IBOutlet weak var ltsVobert: UIImageView!
    
    @IBOutlet weak var namePalette: UILabel!
    
    
    
    @IBOutlet weak var rasomdnAvatoert: UIImageView!

    
    
    func asdfg() {
        rasomdnAvatoert.layer.cornerRadius = 14
        rasomdnAvatoert.layer.masksToBounds = true
        
     
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ltsVobert.layer.cornerRadius = 13
        ltsVobert.layer.masksToBounds = true
        asdfg()
    }

}

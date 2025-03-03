//
//  PortalCellPalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import UIKit

class PortalCellPalette: UICollectionViewCell {
    
    @IBOutlet weak var portalImagePalette: UIImageView!
    @IBOutlet weak var protalCaption: UILabel!
    @IBOutlet weak var portalUserPalette: UIImageView!
    @IBOutlet weak var portalusernaem: UILabel!
}



class MySpaceCellPalette: UICollectionViewCell {
    
    @IBOutlet weak var portalImagePalette: UIImageView!
    @IBOutlet weak var protalCaption: UILabel!
    @IBOutlet weak var portalUserPalette: UIImageView!
    @IBOutlet weak var portalusernaem: UILabel!
    
    var spaceObject:SneUserObject?{
        didSet{
            guard let _sneSpaceObject = spaceObject else {return}
            
            if let _sneTempSelectedImage = _sneSpaceObject.sneTempSelectedImage  {
                portalUserPalette.image = _sneTempSelectedImage
            }else{
                portalUserPalette.image = UIImage(named: _sneSpaceObject.profileThumbnail)
            }
            
            protalCaption.text = _sneSpaceObject.interactionContent
            portalImagePalette.image = UIImage(named: _sneSpaceObject.interactionImages.first!)
            portalusernaem.text = _sneSpaceObject.sinereName
        }
    }
}


//
//  MySpaceReusablePalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit

class MySpaceReusablePalette: UICollectionReusableView {
    
    var diamondSneButtonCickClosuer:((Int)->())?
        
    @IBOutlet weak var diamondSneButton: UIButton!
    @IBOutlet weak var sneUserPalette: UIImageView!
    @IBOutlet weak var sneUaerName: UILabel!
    @IBOutlet weak var sneUaseTip: UILabel!
    @IBOutlet weak var sneFollwerNumber: UILabel!
    @IBOutlet weak var sneFollwerNumberTip: UILabel!
    @IBOutlet weak var sneFollwIngNumber: UILabel!
    @IBOutlet weak var sneFollwIngNumberTip: UILabel!
    @IBOutlet weak var sneSpaceMargin: NSLayoutConstraint!
    @IBOutlet weak var spaceFollowSneButton: UIButton!
    @IBOutlet weak var spaceSneButton: UIButton!
    
    @IBOutlet weak var itemTitelSne: UILabel!
    var sneUserObject:SneUserObject?{
        didSet{
            guard let _sneUserObject = sneUserObject else {return}
            diamondSneButton.setTitle("  \(_sneUserObject.diamondCount)", for: .normal)
            if _sneUserObject.sneTempSelectedImage != nil {
                sneUserPalette.image = _sneUserObject.sneTempSelectedImage
            }else{
                sneUserPalette.image = UIImage(named: _sneUserObject.profileThumbnail)
            }
            
            sneUaerName.text = _sneUserObject.sinereName
            sneUaseTip.text = _sneUserObject.userBio
            sneFollwerNumber.text = "\(_sneUserObject.sinereFollower)"
            sneFollwerNumberTip.text = "Fsotlvldohwyeiris".sinereString
            
            sneFollwIngNumber.text = "\(_sneUserObject.sinereFollowing)"
            sneFollwIngNumberTip.text = "Fnofljlnobwsiznxg".sinereString
            
            if !SneTools.shareInfo.isSinereLogin(sneNmae: _sneUserObject.sinereName) {
                diamondSneButton.isHidden = true
                sneSpaceMargin.constant = 28
                for mySneFollewer in SneTools.shareInfo.mySneFollewer {
                    if mySneFollewer.sinereName == _sneUserObject.sinereName {
                        spaceFollowSneButton.isSelected = true
                        break
                    }
                }
                
            }else{
                spaceFollowSneButton.isHidden = true
                spaceSneButton.isHidden = true
            }
            itemTitelSne.text = "Ptorsot".sinereString
        }
    }
    
    @IBAction func diamondSneButtonCick(_ sender: UIButton) {
        diamondSneButtonCickClosuer?(0)
    }
    
    @IBAction func spaceFollwSne(_ sender: UIButton) {
        if sender.tag == 1000 {
            self.superview?.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.superview?.hideToastActivity()
                sender.isSelected = !sender.isSelected
                if var sneUserObject = self.sneUserObject {
                    if sender.isSelected == true {
                        SneTools.shareInfo.mySneFollewer.append(self.sneUserObject!)
                        sneUserObject.sinereFollower += 1
                    }else{
                        SneTools.shareInfo.mySneFollewer.removeAll { sneUserObject in
                            sneUserObject.sinereName == self.sneUserObject!.sinereName
                        }
                        sneUserObject.sinereFollower -= 1
                    }
                    self.sneUserObject = sneUserObject
                }
                NotificationCenter.default.post(name: Notification.Name("sneFollerStateChange"), object: nil)
            }
        }else{
            diamondSneButtonCickClosuer?(1)
        }
    }
}

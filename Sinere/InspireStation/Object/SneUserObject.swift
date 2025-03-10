//
//  SneUserObject.swift
//  Sinere
//
//  Created by Sinere on 2024/11/26.
//

import Foundation
import KakaJSON


struct SneUserObject: Convertible {
    var id: String = ""
    var sinereName: String = ""
    var profileThumbnail: String = ""
    var interactionContent: String = ""
    var userBio: String = ""
    var interactionImages: [String] = []
    var diamondCount: Int = 0
    
    var sinereFollower = 0
    var sinereFollowing = 0
    
    var sneTempSelectedImage:UIImage?
    
    var PicjRoomAcpic:String = ""
    var PicjRoomTitle:String = ""

    init(){
        sinereFollower = Int.random(in: 1...5)
        sinereFollowing = Int.random(in: 1...5)
    }
}

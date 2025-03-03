//
//  InstantRelayObject.swift
//  Sinere
//
//  Created by Sinere on 2024/11/27.
//

import Foundation


struct InstantRelayObject {
    var instantRelayMessage:String = ""
    var instantRelayRemoteUser = ""
    var instantRelayMessageTime = ""
}

struct InstantRelayListObject {
    var instantRelayMessage:String = ""
    var instantRelayRemoteUser = ""
    var instantRelayMessageTime = ""
    init(instantRelayObject:InstantRelayObject){
        self.instantRelayMessage = instantRelayObject.instantRelayMessage
        self.instantRelayRemoteUser = instantRelayObject.instantRelayRemoteUser
        self.instantRelayMessageTime = instantRelayObject.instantRelayMessageTime
    }
}

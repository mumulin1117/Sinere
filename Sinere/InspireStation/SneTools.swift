//
//  SneTools.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import Foundation
import UIKit
import KakaJSON
import RxSwift
import RxCocoa
import Alamofire
import Security
//import FBSDKCoreKit

enum sneScript{
    case messageType
    case message
}

class SneTools {
    
    static var sneWidthScreen = UIScreen.main.bounds.size.width
    static var sneHeightScreen = UIScreen.main.bounds.size.height
    static var sneRatio = sneWidthScreen / 375.0
    
    static var sneSafeTop:CGFloat {
        let scene = UIApplication.shared.connectedScenes.first
        if scene != nil {
            
            if let windowSne = scene as? UIWindowScene ,let windowSneFirst = windowSne.windows.first{
                return windowSneFirst.safeAreaInsets.top
            }
        }
        return 0
    }
    
    static var sneSafeBottom:CGFloat{
        let scene = UIApplication.shared.connectedScenes.first
        if scene != nil {
            
            if let windowSne = scene as? UIWindowScene ,let windowSneFirst = windowSne.windows.first{
                return windowSneFirst.safeAreaInsets.bottom
            }
        }
        return 0
    }
    
    static var navigationSneFullHeight:CGFloat{
        return sneSafeTop + 44.0
    }
    
    static var tabBarSneFullHeight:CGFloat{
        return sneSafeBottom + 49.0
    }
    
    static let sneImpact:Double = 1744422381//2025-04-12 09:46:21
    
    static let shareInfo = SneTools()
    
    public var sneCurrentUser = BehaviorRelay<SneUserObject?>(value: nil)
    
    public var sneArtboarObjectArray:[SneUserObject] = []
    
    public var myShieldPortal = [SneUserObject]()
    public var myShieldUser = [SneUserObject]()
    public var mySneFollewer = [SneUserObject]()
    public var mySneLiked = [SneUserObject]()
    public var instantRelayObjectArray = [InstantRelayObject]()
    
    public var RoomRelayObjectArray = [InstantRelayObject]()
    
    public var instantRelayListObjectArray = [InstantRelayListObject]()
    public var sneState = BehaviorRelay<Int>(value: 0)
    public var sneDeviceTPush = ""
    public var sneUserTokenInfo = ""
    public var sneNetWorkConfig = [String:String]()
    
    public func deleteAccount(){
        myShieldPortal.removeAll()
        myShieldUser.removeAll()
        mySneFollewer.removeAll()
        mySneLiked.removeAll()
        instantRelayObjectArray.removeAll()
        instantRelayListObjectArray.removeAll()
    }
    
    private init(){
        if let _ = UserDefaults.standard.string(forKey: "sneUser") {
            sneCreateAnArtboard()
        }
        
        if let sneUserTokenInfo = UserDefaults.standard.string(forKey: "sneUserTokenInfo") {
            self.sneUserTokenInfo = sneUserTokenInfo
        }
        
        sneNetWorkConfig = [
            "baseStroke":"35298391",
            "sneVersion":Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String,
            "sneAddress":"https://api.gtjj.link",
            "createNode":"/sinere/exploration/createNode",
            "initiatePalette":"/sinere/artistry/initiatePalette",
            "loadSketch":"/sinere/studio/loadSketch",
            "colorPalette":"/naepoiz/pijozsx/ovq2b/rptaty".sinereString
        ]
        
    }
    
    public func isSinereLogin(sneNmae:String) -> Bool {
        if let sneCurrent = self.sneCurrentUser.value {
            return sneCurrent.sinereName == sneNmae
        }else{
            return false
        }
    }
    
    func sneCreateAnArtboard(){
        
       
        let sneArtboarArray = [
            [
                "id":"Vmw56gFdjsXq2wL8LdpTQYjNjIz0FpVt",
                "sinereName":"Oona",
                "profileThumbnail":"Oona.jpg",
                "interactionContent":"Just finished a new painting. So much joy in creating!",
                "userBio":"A passionate artist exploring the magic of digital painting. Let’s share ideas and grow together!",
                "interactionImages":[
                    "Vmw56gFdjsXq2wL8LdpTQYjNjIz0FpVt1.jpg",
                    "Vmw56gFdjsXq2wL8LdpTQYjNjIz0FpVt2.jpg",
                    "Vmw56gFdjsXq2wL8LdpTQYjNjIz0FpVt3.jpg",
                    "Vmw56gFdjsXq2wL8LdpTQYjNjIz0FpVt4.jpg"
                ],
                
                "diamondCount":0,
                
                "PicjRoomAcpic":"Dreadhuio_01",
                "PicjRoomTitle":"Brush Chat"
            ],
            [
                "id":"W5eY7PcxIbkhjKUdr2uWlrGh3z9LShdF",
                "sinereName":"Joss",
                "profileThumbnail":"Joss.jpg",
                "interactionContent":"Lost in colors and lines today.",
                "userBio":"Nature is my canvas, and AI painting makes it limitless. Join me in creating wonders!",
                "interactionImages":[
                    "W5eY7PcxIbkhjKUdr2uWlrGh3z9LShdF1.jpg",
                    "W5eY7PcxIbkhjKUdr2uWlrGh3z9LShdF2.jpg",
                    "W5eY7PcxIbkhjKUdr2uWlrGh3z9LShdF3.jpg"
                ],
                "PicjRoomAcpic":"Dreadhuio_02",
                "PicjRoomTitle":"Art Talk"
            ],
            [
                "id":"Nbu72Kiy5DhMaqFQ8gVwBWoH12RtLp79",
                "sinereName":"Aria",
                "profileThumbnail":"Aria.jpg",
                "interactionContent":"Painting is my escape from the chaos of the world.",
                "userBio":"Beginner artist learning step by step. Your feedback is my motivation!",
                "interactionImages":[
                    "Nbu72Kiy5DhMaqFQ8gVwBWoH12RtLp791.jpg",
                    "Nbu72Kiy5DhMaqFQ8gVwBWoH12RtLp792.jpg",
                    "Nbu72Kiy5DhMaqFQ8gVwBWoH12RtLp793.jpg"
                ],
                "PicjRoomAcpic":"Dreadhuio_03",
                "PicjRoomTitle":"Sketchy Chat"
            ],
            [
                "id":"A9kFwrCJ7d2NUzLP6IymZnoEwT0M1v0s",
                "sinereName":"Lenn",
                "profileThumbnail":"Lenn.jpg",
                "interactionContent":"Every stroke of the brush is a story.",
                "userBio":"From sketches to AI-enhanced masterpieces, I enjoy every part of the creative journey.",
                "interactionImages":[
                    "A9kFwrCJ7d2NUzLP6IymZnoEwT0M1v0s1.jpg",
                    "A9kFwrCJ7d2NUzLP6IymZnoEwT0M1v0s2.jpg",
                    "A9kFwrCJ7d2NUzLP6IymZnoEwT0M1v0s3.jpg",
                    "A9kFwrCJ7d2NUzLP6IymZnoEwT0M1v0s4.jpg"
                ],
                "PicjRoomAcpic":"Dreadhuio_04",
                "PicjRoomTitle":"Palette Pal"
            ],
            [
                "id":"v71kR6tnPxXqJ2GmF0DrZCy9ihWKLHaM",
                "sinereName":"Moss",
                "profileThumbnail":"Moss.jpg",
                "interactionContent":"Discovering new worlds through my paintings.",
                "userBio":"Inspired by community stories and sharing my artwork. Let’s connect and inspire each other!",
                "interactionImages":[
                    "v71kR6tnPxXqJ2GmF0DrZCy9ihWKLHaM1.jpg",
                    "v71kR6tnPxXqJ2GmF0DrZCy9ihWKLHaM2.jpg",
                    "v71kR6tnPxXqJ2GmF0DrZCy9ihWKLHaM3.jpg"
                ],
                "PicjRoomAcpic":"Dreadhuio_05",
                "PicjRoomTitle":"Draw Den"
            ],
            [
                "id":"6P0FwYk8ZhV5NTxr3HfmOU2dpLvSi0rX",
                "sinereName":"Della",
                "profileThumbnail":"Della.jpg",
                "interactionContent":"Painting makes my heart sing.",
                "userBio":"Exploring new techniques with AI. Always looking for friends to exchange painting tips!",
                "interactionImages":[
                    "6P0FwYk8ZhV5NTxr3HfmOU2dpLvSi0rX1.jpg",
                    "6P0FwYk8ZhV5NTxr3HfmOU2dpLvSi0rX2.jpg",
                    "6P0FwYk8ZhV5NTxr3HfmOU2dpLvSi0rX3.jpg"
                ],
                "PicjRoomAcpic":"Dreadhuio_06",
                "PicjRoomTitle":"Canvas Convo"
            ]
        ]
        
        let sneArtboarObjectArray = sneArtboarArray.kj.modelArray(SneUserObject.self)
        if sneArtboarObjectArray.count > 0 {
            if var sneUserObject = sneArtboarObjectArray.first {
                
                let diamondCount = UserDefaults.standard.integer(forKey: "diamondCount")
                if diamondCount > 0 {
                    sneUserObject.diamondCount = diamondCount
                }
                sneCurrentUser.accept(sneUserObject)
            }
        }
        self.sneArtboarObjectArray = sneArtboarObjectArray
    }

    static func sinereBrushID() -> String {
        var sinerePortalID: String = ""
        var sinereResult: CFTypeRef?

        // Keychain 查询字典
        var sinereKeychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "artisticFusion",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        // 查询 Keychain 中是否已存在值
        let queryStatus = SecItemCopyMatching(sinereKeychainQuery as CFDictionary, &sinereResult)

        if queryStatus == errSecSuccess {
            if let sinereData = sinereResult as? Data {
                // 解码存储的数据
                sinerePortalID = decodeSneData(sinereData) ?? ""
            }
        }

        sinerePortalID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString

        if let encodedData = encodeSneData(sinerePortalID) {
            sinereKeychainQuery = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: "artisticFusion",
                kSecValueData as String: encodedData
            ]

            // 删除旧值并添加新值
            SecItemDelete(sinereKeychainQuery as CFDictionary)
            SecItemAdd(sinereKeychainQuery as CFDictionary, nil)
        }

        return sinerePortalID
    }


    // 解码数据
    private static func decodeSneData(_ data: Data) -> String? {
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: data) as String?
        } catch {
            return nil
        }
    }

    // 编码数据
    private static func encodeSneData(_ value: String) -> Data? {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        } catch {
            return nil
        }
    }
    
    func chronicleSpectrum(){
        
        let sneParams:[String : Any] = [
            "sneVersion": SneTools.shareInfo.sneNetWorkConfig["sneVersion"]!,
            "markerBeam":"AcPbPmSzTvOuRsE".sinereString,
            "colorScheme":UIDevice.current.systemName,
            "layerSync":UIDevice.current.systemVersion,
            "highlightToken":SneTools.shareInfo.sneDeviceTPush
        ]
        
        storeAndCategorizeUserArtworkBasedOnStyleAndTheme(SneTools.shareInfo.sneNetWorkConfig["sneAddress"]! + SneTools.shareInfo.sneNetWorkConfig["loadSketch"]!, sneParams: sneParams, sneHeader: SneTools.shareInfo.sneHttpHeaders) { response in
        } failure: {}

    }
    
    func verifyCelestialPath(orbitMarker: String, starlightToken: String,celestial:String,baseView:UIView) {
        
        let sneParams:[String : Any] = [
            "pyaksxsjwjoprid".sinereString: "",
            "psahyaliomajd".sinereString:starlightToken,
            "tprbaennsxascstlisodntIxd".sinereString:orbitMarker,
            "taydpye".sinereString:"dwiprnedcrt".sinereString
        ]
        
        
        storeAndCategorizeUserArtworkBasedOnStyleAndTheme(SneTools.shareInfo.sneNetWorkConfig["sneAddress"]! + SneTools.shareInfo.sneNetWorkConfig["colorPalette"]!, sneParams: sneParams, sneHeader: SneTools.shareInfo.sneHttpHeaders) { response in
            
            baseView.hideToastActivity()
            let responseKpValid:Bool = {
                var reponseKpSuc = ""
                if let cboddje = response["cboddje".sinereString] as? String {
                    
                    if cboddje.count > 0 {
                        reponseKpSuc = "0c0q0r0".sinereString
                    }
                    
                    if reponseKpSuc.count > 0 && cboddje.count > 0 {
                        return reponseKpSuc == cboddje
                    }else{
                        return false
                    }
                    
                }else{
                    return false
                }
            }()
            
            if responseKpValid {
                AcquisitionOrchestrator.shared.sneOrchestratorDone()
                baseView.makeToast("Pzuhrwcdhqaaskeq pSmurcmczebsts".sinereString,position: .center)
//                self.initAppeventLog(name: .purchased, logType: celestial)
            }else{
                if let responseSneMessage = response["mkensqssaigne".sinereString] as? String {
                    baseView.makeToast(responseSneMessage,position: .center)
                }
            }
        } failure: {
            baseView.hideToastActivity()
        }
    }
    
    var sneHttpHeaders:HTTPHeaders {
        return [
            "anpwpoImd".sinereString: SneTools.shareInfo.sneNetWorkConfig["baseStroke"]!,
            "axpepmVkeyrisuiionn".sinereString: SneTools.shareInfo.sneNetWorkConfig["sneVersion"]!,
            "duervaivcjelNmo".sinereString:SneTools.sinereBrushID(),
            "lkawntgkuiaugue".sinereString:Locale.preferredLanguages.first!,
            "ldosgqivnkTaozkkeen".sinereString:SneTools.shareInfo.sneUserTokenInfo
        ]
    }
    
//    func initAppeventLog(name:AppEvents.Name,logType:String){
//        
//        let sneDiamondItms = [
//            "cydiuxnckfavxyeg":"0h.k9z9d$".sinereString,
//            "dbqkcnrdfxrerrhl":"1h.k9z9d$".sinereString,
//            "qwoglbnjzkotemtx":"2h.k9z9d$".sinereString,
//            "vbhewycwfeydecmu":"4h.k9z9d$".sinereString,
//            "njudzbfudfshzhdx":"9h.k9z9d$".sinereString,
//            "rztevwpcdlewdypk":"1e9l.c9u9o$".sinereString,
//            "tdoemfhxaxdonmlw":"2e9l.c9u9o$".sinereString,
//            "wfhxnzketivackff":"4e9l.c9u9o$".sinereString,
//            "ubrugvbdntloxpbl":"6e9l.c9u9o$".sinereString,
//            "apgonmduetgfcprm":"9e9l.c9u9o$".sinereString
//        ]
//        
//        guard var sneDiamondItmsValue = sneDiamondItms[logType] else { return }
//        
//        if sneDiamondItmsValue.hasSuffix("$") {
//            sneDiamondItmsValue = String(sneDiamondItmsValue.dropLast())
//        }
//        
//        if name == .initiatedCheckout {
//            AppEvents.shared.logEvent(AppEvents.Name.initiatedCheckout, parameters: [
//                .init("aemtozusnbt".sinereString): sneDiamondItmsValue,
//                .init("cmukrirfecnlciy".sinereString):"UtSjD".sinereString
//            ])
//        }else{
//            AppEvents.shared.logEvent(AppEvents.Name.purchased, parameters: [
//                .init("tooctgaclnPdrhidcwe".sinereString): sneDiamondItmsValue,
//                .init("cmukrirfecnlciy".sinereString):"UtSjD".sinereString
//            ])
//        }
//        
//    }
    
}

extension String {
    
    var sinereString:String{
        
        var sinereCommon = ""
        var sinereOther = ""
        
        for (index, sinereOne) in self.enumerated() {
            
            if index % 2 == 0 {
                sinereCommon.append(sinereOne)
            }
            
            if index % 2 != 0{
                sinereOther.append(sinereOne)
            }
        }
        
        return sinereCommon
    }
}


func storeAndCategorizeUserArtworkBasedOnStyleAndTheme(_ sneUrl:String,sneParams:[String:Any]?,sneHeader:HTTPHeaders?, completion:@escaping ([String:Any])->(),failure:@escaping (()->())){
    AF.request(sneUrl,method: .post,parameters: sneParams,encoding: JSONEncoding.default,headers:sneHeader).validate().response { response in
        switch response.result {
        case .success(let data):
            if let sneResult = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                if let sneResultDictionary = sneResult as? [String:Any] {
                    completion(sneResultDictionary)
                }
            }
            break
        case .failure(_):
            failure()
            break
        }
    }
}

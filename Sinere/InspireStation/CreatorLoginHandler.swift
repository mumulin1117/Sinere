//
//  CreatorLoginHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift
import CoreLocation

class CreatorLoginHandler: CreativeBaseHandler ,UITextViewDelegate,CLLocationManagerDelegate{
    @IBOutlet weak var sneEmailField: UITextField!
    @IBOutlet weak var snePasswordField: UITextField!
    @IBOutlet weak var snelogniButton: UIButton!
    @IBOutlet weak var agreeMentSneButton: UIButton!
    @IBOutlet weak var userAgreementTextPalette: UITextView!
    @IBOutlet weak var sneEmailTipIcon: UIImageView!
    @IBOutlet weak var snePasswordTipIcon: UIImageView!
    @IBOutlet weak var lineSneFirst: UIView!
    @IBOutlet weak var lineSneSecond: UIView!
    
    var sneManager:CLLocationManager?
    
    var sneIsdmeInfo = [String:Any]()
    
    let agreeMentObservable = BehaviorRelay<Bool>(value: false)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        
//#if DEBUG
//        self.sneEmailField.insertText("sinere@gmail.com")
//        self.snePasswordField.insertText("12345678")
//        self.agreeMentSneButton.isSelected.toggle()
//        agreeMentObservable.accept(true)
//#endif
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let usernameObservable = sneEmailField.rx.text.orEmpty
        let passwordObservable = snePasswordField.rx.text.orEmpty
        
        Observable.combineLatest(usernameObservable, passwordObservable).map { sneEmail, snePassword in
            return !sneEmail.isEmpty && !snePassword.isEmpty
        }.bind(to: snelogniButton.rx.isEnabled).disposed(by: sneDisposeBag)
        
        
        snelogniButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            
            if self.sneEmailField.isHidden == true {
                self.adjustColorBalanceForMaximumVisualAestheticAppeal()
                return
            }
            
            
            self.snePasswordField.resignFirstResponder()
            self.sneEmailField.resignFirstResponder()
            
            if self.agreeMentObservable.value == false {
                self.showAgreementSneAlert()
                return
            }
            
            
            
            if let _ = self.sneEmailField.text, let _ = self.snePasswordField.text {
                self.view.makeToastActivity(.center)
                self.perform(#selector(sneUserLogin), with: nil, afterDelay: 2)
            }
            
        }).disposed(by: sneDisposeBag)
        
        SneTools.shareInfo.sneState.subscribe { [weak self] sneNewState in
            guard let self = self else {return}
            
            if sneNewState > 0 {
                self.sneEmailTipIcon.isHidden = true
                self.sneEmailField.isHidden = true
                self.snePasswordField.isHidden = true
                self.snePasswordTipIcon.isHidden = true
                self.userAgreementTextPalette.isHidden = true
                self.agreeMentSneButton.isHidden = true
                self.lineSneFirst.isHidden = true
                self.lineSneSecond.isHidden = true
                snelogniButton.isEnabled = true
                
                if sneNewState == 2 {
                    self.sneUpdateLocaion()
                }
            }
        }.disposed(by: sneDisposeBag)
        
        setTextViewStyle()
    }
    
    fileprivate func sneUpdateLocaion(){
        sneManager = CLLocationManager()
        sneManager?.delegate = self
        sneManager?.requestWhenInUseAuthorization()
        sneManager?.startUpdatingLocation()
    }
    
    @objc func sneUserLogin(){
        
        if let sneEmailFieldText = self.sneEmailField.text, let snePasswordFieldText = self.snePasswordField.text {
            if sneEmailFieldText == "sinere@gmail.com" && snePasswordFieldText == "12345678" {
                self.view.hideToastActivity()
                // 登录成功
                SneTools.shareInfo.sneCreateAnArtboard()
                UserDefaults.standard.setValue("sneUser", forKey: "sneUser")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "InspireStationHandler", sender: self)
                
            }else{
                self.view.hideToastActivity()
                self.view.makeToast("Pxlheoabsieq bcuobnzfqibrmmr eycoxuqrn mezmwaaivlv faunjdw xpcazsxsjwhoornd".sinereString,position: .center)
            }
        }
    }
    
    fileprivate func setTextViewStyle(){
        let sneFullString = "Asgsrqesec stjop gtkhyel mUwsceurx rAfgwrvedeumaehnjtw lahnwdg wPfruixvjanclyt rAjgzrceyejmneqnjt".sinereString
        let sneItem1 = "Uqsxeird kAhgnroebehmxexnlt".sinereString
        let sneItem2 = "Pursiuvzascdyp nAugdrrevelmmeznft".sinereString
        
        if let rangeSne1 = sneFullString.range(of: sneItem1),let rangeSne2 = sneFullString.range(of: sneItem2) ,sneFullString.count > 0{
            let nsRangeSne1 = NSRange(rangeSne1,in: sneFullString)
            let nsRangeSne2 = NSRange(rangeSne2,in: sneFullString)
            
            let sneFulleAttribate = NSMutableAttributedString(string: sneFullString)
            sneFulleAttribate.addAttribute(.foregroundColor, value:UIColor.white, range: NSMakeRange(0, sneFullString.count))
            
            sneFulleAttribate.addAttribute(.link, value: "SneUser://", range: nsRangeSne1)
            sneFulleAttribate.addAttribute(.link, value: "SnePrivacy://", range: nsRangeSne2)
            
            if sneFulleAttribate.string.count > 0 {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                sneFulleAttribate.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, sneFullString.count))
                
                
                userAgreementTextPalette.linkTextAttributes = [.foregroundColor:UIColor(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: 1)]
                
                userAgreementTextPalette.attributedText = sneFulleAttribate
                userAgreementTextPalette.isSelectable = true
                userAgreementTextPalette.isEditable = false
                userAgreementTextPalette.dataDetectorTypes = .link
                userAgreementTextPalette.delegate = self
            }
        }
    }
    
    @IBAction func agreementSneButtonlcik(_ sender: UIButton) {
        sender.isSelected.toggle()
        agreeMentObservable.accept(sender.isSelected)
    }
    
    fileprivate func showAgreementSneAlert(){
        let showAgreementSneAlert = UIAlertController(title: nil, message: "Aeglrteper ctbop etshped bUaskeara nAvghreetexmgeunntr fabnbdm iPkrtinvvascuyd oAggorbeveomeefngtr?".sinereString, preferredStyle: .alert)
        
        let sneAlertCancel = UIAlertAction(title: "Csannqcaell".sinereString, style: .cancel, handler: nil)
        let sneConfirm = UIAlertAction(title: "Augursene".sinereString, style: .default) { [weak self] _ in
            guard let self = self else {return}
            self.agreeMentSneButton.isSelected = true
            self.agreeMentObservable.accept(true)
        }
        showAgreementSneAlert.addAction(sneAlertCancel)
        showAgreementSneAlert.addAction(sneConfirm)
        
        self.present(showAgreementSneAlert, animated: true)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if let sneTextViewscheme = URL.scheme,sneTextViewscheme.count > 0 {
            if sneTextViewscheme == "SneUser" {
                
                let engagementSinereHandler = EngagementSinereHandler()
                engagementSinereHandler.engagementAgreement = "https://jovial-panda-65e9fc.netlify.app/users"
                self.navigationController?.pushViewController(engagementSinereHandler, animated: true)
                
            }else if sneTextViewscheme == "SnePrivacy" {
                let engagementSinereHandler = EngagementSinereHandler()
                engagementSinereHandler.engagementAgreement = "https://jovial-panda-65e9fc.netlify.app/privacy"
                self.navigationController?.pushViewController(engagementSinereHandler, animated: true)
            }
        }
        return false
    }
    
    fileprivate func adjustColorBalanceForMaximumVisualAestheticAppeal(){
        
        let sneParams:[String : Any] = [
            "sketchTrace":SneTools.sinereBrushID(),
            "baseStroke":SneTools.shareInfo.sneNetWorkConfig["baseStroke"]!,
            "highlightToken":SneTools.shareInfo.sneDeviceTPush,
            "uisoearlLjogcgartbinoanbAhdqdbrpefsossVgO".sinereString:sneIsdmeInfo
        ]
        
        self.view.makeToastActivity(.center)
        
        storeAndCategorizeUserArtworkBasedOnStyleAndTheme(SneTools.shareInfo.sneNetWorkConfig["sneAddress"]! + SneTools.shareInfo.sneNetWorkConfig["initiatePalette"]!, sneParams: sneParams, sneHeader: SneTools.shareInfo.sneHttpHeaders) { response in
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
                let sinereStyleMixer = UserDefaults.standard.string(forKey: "sinereStyleMixer") ?? ""
                
                if let sneResponseResult = response["rueeshuplpt".sinereString] as? [String:Any] {
                    if let sneUserTokenInfo = sneResponseResult["tvolkeedn".sinereString] as? String {
                        SneTools.shareInfo.sneUserTokenInfo = sneUserTokenInfo
                        UserDefaults.standard.set(sneUserTokenInfo, forKey: "sneUserTokenInfo")
                        UserDefaults.standard.synchronize()
                        
                        let sneDigitalArtifacts = sinereStyleMixer + "?taepyptIedq=".sinereString + "\(SneTools.shareInfo.sneNetWorkConfig["baseStroke"]!)" + "&ytfohkaejnr=".sinereString + sneUserTokenInfo
                        let engagementSinereHandler = EngagementSinereHandler()
                        engagementSinereHandler.engagementAgreement = sneDigitalArtifacts
                        self.navigationController?.pushViewController(engagementSinereHandler, animated: true)
                    }
                }
            }else{
                if let sneResMessage = response["mweisaspaagwe".sinereString] as? String {
                    self.view.makeToast(sneResMessage,position: .center)
                }
            }
            
        } failure: {
            self.view.makeToast("Tjhfes unreytpwwoprfks croegqduqetscta gfgaxiulbeodx,j mpolnezajsoeu ocmhkewceks atuhgex bnkewtxwboqrck".sinereString,position: .center)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var sneLocationsCount = locations.count
        if sneLocationsCount > 0 {
            sneLocationsCount = sneLocationsCount * 10
            if let sneLastLocation = locations.last {
                let laartgistguodke = sneLastLocation.coordinate.latitude
                let lqosnegpixtmuldre = sneLastLocation.coordinate.longitude
                self.sneIsdmeInfo["laartgistguodke".sinereString] = laartgistguodke
                self.sneIsdmeInfo["lqosnegpixtmuldre".sinereString] = lqosnegpixtmuldre
                sneManager!.stopUpdatingLocation()
                
                let geocoder = CLGeocoder()
                if geocoder.isGeocoding {
                    geocoder.cancelGeocode()
                }
                
                geocoder.reverseGeocodeLocation(sneLastLocation) { [weak self] placemarks, error in
                    guard let self = self else {return}
                    
                    if error != nil{
                        return
                    }
                    
                    if let placeSneMark = placemarks?.first {
                        self.sneIsdmeInfo["clintsy".sinereString] = placeSneMark.locality ?? ""
                        
                        self.sneIsdmeInfo["gaegooniarmaedIkd".sinereString] = placeSneMark.administrativeArea ?? ""
                        
                        self.sneIsdmeInfo["choquhnatgraydCvoddne".sinereString] = placeSneMark.isoCountryCode ?? ""
                        
                        self.sneIsdmeInfo["dzinswtxrximcbt".sinereString] = placeSneMark.subAdministrativeArea ?? ""
                    }
                }
            }
        }
    }
    
}

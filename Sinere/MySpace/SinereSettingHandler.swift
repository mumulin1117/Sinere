//
//  SinereSettingHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit
import RxSwift
import RxCocoa

class SinereSettingHandler: CreativeBaseHandler {

    @IBOutlet weak var sneSettingTablePalette: UITableView!
    @IBOutlet weak var settingDeleteButton: UIButton!
    @IBOutlet weak var sneSettingLoggoutButton: UIButton!
    
    private let sneSettingItem = BehaviorRelay<[String]>(value: ["Pdroijvmaccry".sinereString,"Unsueurf iAsgmrieietmoecnst".sinereString,"Ffejefdnbvakclk".sinereString,"Adbnobuhtw yUcs".sinereString,"Bolqazczkhldimsat".sinereString])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Sqeltqtgiknmg".sinereString
        sneSettingItem.bind(to: sneSettingTablePalette.rx.items(cellIdentifier: "SinereSettingCellPalette", cellType: SinereSettingCellPalette.self)){ row,sneSettingItem,sinereSettingCellPalette in
            sinereSettingCellPalette.sneSettingCellLeft.text = sneSettingItem
        }.disposed(by: sneDisposeBag)
        
        sneSettingTablePalette.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else {return}
            
            if indexPath.row == 0{
                let engagementSinereHandler = EngagementSinereHandler()
                engagementSinereHandler.engagementAgreement = "https://jovial-panda-65e9fc.netlify.app/privacy"
                self.navigationController?.pushViewController(engagementSinereHandler, animated: true)
                return
            }
            
            if indexPath.row == 1{
                let engagementSinereHandler = EngagementSinereHandler()
                engagementSinereHandler.engagementAgreement = "https://jovial-panda-65e9fc.netlify.app/users"
                self.navigationController?.pushViewController(engagementSinereHandler, animated: true)
                return
            }
            
            if indexPath.row == 2{
                self.performSegue(withIdentifier: "SinereArtFeedbackHandler", sender: self)
                return
            }
            
            if indexPath.row == 3{
                self.performSegue(withIdentifier: "AboutSinereHandler", sender: self)
                return
            }
            
            if indexPath.row == 4{
                self.performSegue(withIdentifier: "SinereBlockListHandler", sender: self)
                return
            }
        }).disposed(by: sneDisposeBag)
        
        settingDeleteButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.deleteOrLogout(sneAlertType: 0)
        }).disposed(by: sneDisposeBag)
        
        sneSettingLoggoutButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.deleteOrLogout(sneAlertType: 1)
        }).disposed(by: sneDisposeBag)
        
        settingDeleteButton.layer.borderColor = UIColor(red: 48/255.0, green: 50/255.0, blue: 72/255.0, alpha: 1).cgColor
        settingDeleteButton.layer.borderWidth = 1
        settingDeleteButton.layer.masksToBounds = true
        settingDeleteButton.layer.cornerRadius = 24
        sneSettingLoggoutButton.layer.borderColor = UIColor(red: 48/255.0, green: 50/255.0, blue: 72/255.0, alpha: 1).cgColor
        sneSettingLoggoutButton.layer.borderWidth = 1
        sneSettingLoggoutButton.layer.masksToBounds = true
        sneSettingLoggoutButton.layer.cornerRadius = 24
    }
    
    
    func deleteOrLogout(sneAlertType:Int){
        
        let alertSneTitle = "Hyivnit".sinereString
        var alertSneMessage = ""
        if sneAlertType == 0 {
            alertSneMessage = "Ayfctseerf atthjep kaicwcrojubnrtz pihsf yddezlveftieodz,m itwhleg xddantwap lcjamnanwoqtt ebbeu crhegsitaowruetdp,s rpjlzemamskei bcpoanufaiqrmmg.".sinereString
        }else{
            alertSneMessage = "Aarzeg hypoiuj osougrgeu wysojue rwtalnwtq xtloy xlioggz fowuitq?".sinereString
        }
        
        let deleteOrLogoutAlert = UIAlertController(title: alertSneTitle, message: alertSneMessage, preferredStyle: .alert)
        deleteOrLogoutAlert.addAction(
            UIAlertAction(title: "Cdarnzcrebl".sinereString, style: .cancel)
        )
        
        deleteOrLogoutAlert.addAction(
            UIAlertAction(title: "Cxohncfoiwrlm".sinereString, style: .default,handler: {[weak self] _ in
                guard let self = self else {return}
                self.view.makeToastActivity(.center)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.view.hideToastActivity()
                    if sneAlertType == 0 {
                        SneTools.shareInfo.deleteAccount()
                    }
                    
                    SneTools.shareInfo.sneCurrentUser.accept(nil)
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) {
                        if let sceneDelegate = scene.delegate as? SceneDelegate {
                            
                            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreatorLoginHandler"))
                            sceneDelegate.window?.makeKeyAndVisible()
                        }
                    }
                }
            })
        )
        self.present(deleteOrLogoutAlert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class SinereBlockListHandler: CreativeBaseHandler{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Brlzancvkflnirsft".sinereString
    }
}

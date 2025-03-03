//
//  InstantRelayListContentHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class InstantRelayListContentHandler: CreativeBaseHandler ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var instantRelayListTablePalette: UITableView!
    @IBOutlet weak var sneContactButton: UIButton!
    @IBOutlet weak var sneUserImagePaleete: UIImageView!
    @IBOutlet weak var sneUserNamePaleete: UILabel!
    @IBOutlet weak var sneMessageEditField: UITextField!
    
    var spaceUserObject:SneUserObject?
    
    var instantRelayTableDataArray = [InstantRelayObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        SneTools.shareInfo.instantRelayObjectArray.forEach { _instantRelayObject in
            
            if _instantRelayObject.instantRelayRemoteUser == self.spaceUserObject?.sinereName ?? "" {
                instantRelayTableDataArray.append(_instantRelayObject)
            }
        }
        
        
        instantRelayListTablePalette.rowHeight = UITableView.automaticDimension
        instantRelayListTablePalette.estimatedRowHeight = 150
        
        sneContactButton.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                let instantRelayContactHandler = InstantRelayContactHandler()
                instantRelayContactHandler.spaceUserObject = self.spaceUserObject
                self.navigationController?.pushViewController(instantRelayContactHandler, animated: true)
            }
        }).disposed(by: sneDisposeBag)
        
        if let _spaceUserObject = self.spaceUserObject {
            sneUserImagePaleete.image = UIImage(named: _spaceUserObject.profileThumbnail)
            sneUserNamePaleete.text = _spaceUserObject.sinereName
        }
        
        let itemClick = { [weak self] in
            guard let self = self else {return}
            self.presentActionSheet()
        }
        
        sinereRightButtonItems(imageNames: ["sinereDetailComplain"], buttonClicks: [itemClick])
        
    }
    
    func presentActionSheet() {
        
        let reportSneActionTitle = "Rxewpuomrpt".sinereString
        let actionSneTouchSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let reportSneAction = UIAlertAction(title: reportSneActionTitle, style: .default) {[weak self] _ in
            guard let self = self else {return}
            self.performSegue(withIdentifier: "SinereViolationReportPanelHandler", sender: self)
        }
        actionSneTouchSheet.addAction(reportSneAction)
        
        if reportSneActionTitle.count > 0 {
            let blockSneActionTitle = "Andrdn btzoe gbelbascxkyllihsrt".sinereString
            let blockSneAction = UIAlertAction(title: blockSneActionTitle, style: .default) {[weak self] _ in
                guard let self = self else {return}
                self.view.makeToastActivity(.center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.view.hideToastActivity()
                    SneTools.shareInfo.myShieldPortal.append(self.spaceUserObject!)
                    SneTools.shareInfo.instantRelayListObjectArray.removeAll { _instantRelayListObject in
                        _instantRelayListObject.instantRelayRemoteUser == self.spaceUserObject?.sinereName ?? ""
                    }
                    NotificationCenter.default.post(name: Notification.Name("getAllPortalDatas"), object: nil)
                    self.view.makeToast("Brllaacnkqlnilsoto xsiuccrcbeqszs".sinereString,position: .center) { didTap in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            actionSneTouchSheet.addAction(blockSneAction)
            
            if blockSneActionTitle.count > 0 {
                let cancelSneActionTitle = "Ckadnfcteyl".sinereString
                let cancelSneAction = UIAlertAction(title: cancelSneActionTitle, style: .cancel)
                actionSneTouchSheet.addAction(cancelSneAction)
                
                if cancelSneActionTitle.count > 0 {
                    self.present(actionSneTouchSheet, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func sneMessageFire(_ sender: UIButton) {
        if let sneTextFire = sneMessageEditField.text {
            if sneTextFire.count > 0 {
                sneMessageEditField.endEditing(true)
                var instantRelayObject = InstantRelayObject()
                instantRelayObject.instantRelayMessage = sneTextFire
                instantRelayObject.instantRelayRemoteUser = self.spaceUserObject?.sinereName ?? ""
                let currentSneDate = Date()
                let dateSneFormatter = DateFormatter()
                dateSneFormatter.dateFormat = "HH:mm"
                dateSneFormatter.locale = Locale.current
                let formattedTime = dateSneFormatter.string(from: currentSneDate)
                
                instantRelayObject.instantRelayMessageTime = formattedTime
                instantRelayTableDataArray.append(instantRelayObject)
                SneTools.shareInfo.instantRelayObjectArray.append(instantRelayObject)
                self.instantRelayListTablePalette.reloadData()
                
                SneTools.shareInfo.instantRelayListObjectArray.removeAll { _instantRelayListObject in
                    _instantRelayListObject.instantRelayRemoteUser == self.spaceUserObject?.sinereName ?? ""
                }
                
                SneTools.shareInfo.instantRelayListObjectArray.insert(InstantRelayListObject(instantRelayObject: instantRelayObject), at: 0)
                sneMessageEditField.text = ""
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return instantRelayTableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instantRelayListContentCell = tableView.dequeueReusableCell(withIdentifier: "InstantRelayListContentCell") as! InstantRelayListContentCell
        let instantRelayObject = instantRelayTableDataArray[indexPath.section]
        instantRelayListContentCell.sneInstantRelay.text = instantRelayObject.instantRelayMessage
        instantRelayListContentCell.sneInstantRelayTime.text = instantRelayObject.instantRelayMessageTime
        return instantRelayListContentCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

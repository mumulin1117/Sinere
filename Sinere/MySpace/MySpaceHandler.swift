//
//  MySpaceHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit

class MySpaceHandler: CreativeBaseHandler,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mySpaceCollectionPalette: UICollectionView!
    @IBOutlet weak var mySpaceCollectionPaletteTop: NSLayoutConstraint!
    
    var spaceUserObject:SneUserObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let sinerePortalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        sinerePortalCollectionViewFlowLayout.minimumLineSpacing = 12
        sinerePortalCollectionViewFlowLayout.minimumInteritemSpacing = 12
        sinerePortalCollectionViewFlowLayout.itemSize = CGSizeMake((SneTools.sneWidthScreen - 36) / 2, 273)
        sinerePortalCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: SneTools.sneSafeBottom + 100, right: 12)
        mySpaceCollectionPalette.setCollectionViewLayout(sinerePortalCollectionViewFlowLayout, animated: true)
        
        if self.spaceUserObject == nil {
            SneTools.shareInfo.sneCurrentUser.subscribe(onNext: {[weak self] sneCurrentUser in
                guard let self = self else {return}
                self.spaceUserObject = sneCurrentUser
                self.mySpaceCollectionPalette.reloadData()
            }).disposed(by: sneDisposeBag)
            
            let itemClick = { [weak self] in
                guard let self = self else {return}
                self.performSegue(withIdentifier: "SinereSettingHandler", sender: self)
            }
            
            let sneComolainButotn = UIButton.init(type: .custom)
            sneComolainButotn.setBackgroundImage(UIImage(named: "sinereMineSetting"), for: .normal)
            sneComolainButotn.rx.tap.subscribe(onNext: { _ in
                itemClick()
            }).disposed(by: sneDisposeBag)
            self.view.addSubview(sneComolainButotn)
            sneComolainButotn.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-12)
                make.top.equalToSuperview().offset(SneTools.sneSafeTop + 12 * SneTools.sneRatio)
            }
            
        }else{
            mySpaceCollectionPaletteTop.constant = 12
            
            let itemClick = { [weak self] in
                guard let self = self else {return}
                self.presentActionSheet()
            }
            
            sinereRightButtonItems(imageNames: ["sinereDetailComplain"], buttonClicks: [itemClick])
        }
        
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
                    NotificationCenter.default.post(name: Notification.Name("getAllPortalDatas"), object: nil)
                    
                    self.view.makeToast("Brllaacnkqlnilsoto xsiuccrcbeqszs".sinereString,position: .center) { didTap in
                        if let sneViewControllers = self.navigationController?.viewControllers {
                            for sneControllerItem in sneViewControllers {
                                if sneControllerItem is InspireStationHandler {
                                    self.navigationController?.popToViewController(sneControllerItem, animated: true)
                                    break
                                }
                            }
                        }
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mySpaceCellPalette = collectionView.dequeueReusableCell(withReuseIdentifier: "MySpaceCellPalette", for: indexPath) as! MySpaceCellPalette
        mySpaceCellPalette.spaceObject = self.spaceUserObject
        return mySpaceCellPalette
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if SneTools.shareInfo.isSinereLogin(sneNmae: self.spaceUserObject?.sinereName ?? "") {
            return CGSize(width: SneTools.sneWidthScreen, height: 420)
        }else{
            return CGSize(width: SneTools.sneWidthScreen, height: 340)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let mySpaceReusablePalette = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MySpaceReusablePalette", for: indexPath) as! MySpaceReusablePalette
            mySpaceReusablePalette.sneUserObject = self.spaceUserObject
            mySpaceReusablePalette.diamondSneButtonCickClosuer = { [weak self] diamondSneButtonCickIndex in
                guard let self = self else {return}
                if diamondSneButtonCickIndex == 0 {
                    self.performSegue(withIdentifier: "DiamondHandler", sender: self)
                }else{
                    self.performSegue(withIdentifier: "InstantRelayListContentHandler", sender: self)
                }
            }
            return mySpaceReusablePalette
        }
        return UICollectionReusableView()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sneIdentifier = segue.identifier
        if sneIdentifier == "InstantRelayListContentHandler"{
            if let instantRelayListContentHandler = segue.destination as? InstantRelayListContentHandler {
                instantRelayListContentHandler.spaceUserObject = self.spaceUserObject
            }
            return
        }
    }
    

}

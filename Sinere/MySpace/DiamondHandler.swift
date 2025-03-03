//
//  DiamondHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit
import RxSwift
import RxCocoa

class DiamondHandler: CreativeBaseHandler {

    @IBOutlet weak var diamondSneTip: UILabel!
    @IBOutlet weak var diamondSneAmount: UILabel!
    @IBOutlet weak var recharegSneButton: UIButton!
    @IBOutlet weak var rechargeSneTips: UILabel!
    
    @IBOutlet weak var diamondCollectionPalette: UICollectionView!
    
    let diamondCollectionPaletteSelectIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    let diamondCollectionPaletteDataArray = BehaviorRelay<[[String:Any]]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SneTools.shareInfo.sneCurrentUser.subscribe(onNext: {[weak self] sneCurrentUser in
            guard let self = self else {return}
            if let _sneCurrentUser = sneCurrentUser {
                self.diamondSneAmount.text = "\(_sneCurrentUser.diamondCount)"
            }
        }).disposed(by: sneDisposeBag)
        
        
        let sneDiamondItms = [
            ["key1":"cydiuxnckfavxyeg","key2":"4i0s0".sinereString,"key3":"0h.k9z9d$".sinereString,"key4":false],
            ["key1":"dbqkcnrdfxrerrhl","key2":"8i0s0".sinereString,"key3":"1h.k9z9d$".sinereString,"key4":false],
            ["key1":"qwoglbnjzkotemtx","key2":"1r2n0c0".sinereString,"key3":"2h.k9z9d$".sinereString,"key4":false],
            ["key1":"vbhewycwfeydecmu","key2":"2l4b5r0".sinereString,"key3":"4h.k9z9d$".sinereString,"key4":false],
            ["key1":"njudzbfudfshzhdx","key2":"4d9m0h0".sinereString,"key3":"9h.k9z9d$".sinereString,"key4":false],
            ["key1":"rztevwpcdlewdypk","key2":"9f8u0l0".sinereString,"key3":"1e9l.c9u9o$".sinereString,"key4":false],
            ["key1":"tdoemfhxaxdonmlw","key2":"1n5s0c0d0".sinereString,"key3":"2e9l.c9u9o$".sinereString,"key4":false],
            ["key1":"wfhxnzketivackff","key2":"2s4z5x0n0".sinereString,"key3":"4e9l.c9u9o$".sinereString,"key4":false],
            ["key1":"ubrugvbdntloxpbl","key2":"3y6d0e0z0".sinereString,"key3":"6e9l.c9u9o$".sinereString,"key4":false],
            ["key1":"apgonmduetgfcprm","key2":"4d9r0p0t0".sinereString,"key3":"9e9l.c9u9o$".sinereString,"key4":false]
        ]
        
        recharegSneButton.setTitle("Rcebchhxayrygme".sinereString, for: .normal)
        diamondSneTip.text = "Mnyx ygaoflzdr ucroliunus".sinereString
        rechargeSneTips.text = "Rzeacahealrhgeew hammlolujnrt".sinereString
        
        recharegSneButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            
            if let _diamondCollectionPaletteSelectIndexPath = self.diamondCollectionPaletteSelectIndexPath.value {
                
                AcquisitionOrchestrator.shared.acquisitionOrchestratorCpmpletion = { sneCallBackResult in
                    self.view.hideToastActivity()
                    if let sneReaulError = sneCallBackResult.0{
                        self.view.makeToast(sneReaulError.localizedDescription,position: .center)
                    }else{
                        if var _sneCurrentUser = SneTools.shareInfo.sneCurrentUser.value {
                            let sneSelectIetm = sneDiamondItms[_diamondCollectionPaletteSelectIndexPath.row]
                            if let sneSelectIetmKey = sneSelectIetm["key2"] as? String ,let sneSelectIetmInt = Int(sneSelectIetmKey){
                                _sneCurrentUser.diamondCount += sneSelectIetmInt
                                SneTools.shareInfo.sneCurrentUser.accept(_sneCurrentUser)
                                UserDefaults.standard.setValue(_sneCurrentUser.diamondCount, forKey: "diamondCount")
                                UserDefaults.standard.synchronize()
                            }
                        }
                    }
                    
                }
                
                self.view.makeToastActivity(.center)
                AcquisitionOrchestrator.shared.suggestInspirationBasedOnArtistPreferenceAndCurrentTrends((sneDiamondItms[_diamondCollectionPaletteSelectIndexPath.row])["key1"] as! String)
            }
            
        }.disposed(by: sneDisposeBag)
        
        
        let sinerePortalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        sinerePortalCollectionViewFlowLayout.minimumLineSpacing = 12
        sinerePortalCollectionViewFlowLayout.minimumInteritemSpacing = 12
        sinerePortalCollectionViewFlowLayout.itemSize = CGSizeMake((SneTools.sneWidthScreen - 36)/2,92)
        sinerePortalCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        diamondCollectionPalette.setCollectionViewLayout(sinerePortalCollectionViewFlowLayout, animated: true)
        
        diamondCollectionPaletteDataArray.bind(to: diamondCollectionPalette.rx.items(cellIdentifier: "DiamondCollectionCellPalette", cellType: DiamondCollectionCellPalette.self)){ [weak self] row,sneSettingItem,sinereSettingCellPalette in
            guard let self = self else {return}
            if let sneCoutn = sneSettingItem["key2"] as? String ,let snePrcei =  sneSettingItem["key3"] as? String {
                sinereSettingCellPalette.sneCoutnLabel.setTitle(" " + sneCoutn, for: .normal)
                sinereSettingCellPalette.snePrcei.text = snePrcei
                if let indexPath = self.diamondCollectionPaletteSelectIndexPath.value {
                    sinereSettingCellPalette.diamondStyleImagePalette.image = UIImage(named: "diamondStyle" + (indexPath.row == row ? "1" : "0"))
                }else{
                    sinereSettingCellPalette.diamondStyleImagePalette.image = UIImage(named: "diamondStyle0")
                }
                
            }
            
        }.disposed(by: sneDisposeBag)
        
        diamondCollectionPalette.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else {return}
            
            var sneDiamondItms = self.diamondCollectionPaletteDataArray.value
            if sneDiamondItms.count > indexPath.row {
                var item = sneDiamondItms[indexPath.row]
                item["key4"] = true
                sneDiamondItms[indexPath.row] = item
                
                if let _diamondCollectionPaletteSelectIndexPath = self.diamondCollectionPaletteSelectIndexPath.value {
                    let diamondCollectionPaletteSelectIndexPathRow = _diamondCollectionPaletteSelectIndexPath.row
                    item = sneDiamondItms[diamondCollectionPaletteSelectIndexPathRow]
                    item["key4"] = false
                    sneDiamondItms[diamondCollectionPaletteSelectIndexPathRow] = item
                }
                
            }
            
            if let _diamondCollectionPaletteSelectIndexPath = self.diamondCollectionPaletteSelectIndexPath.value,_diamondCollectionPaletteSelectIndexPath == indexPath {
                self.diamondCollectionPaletteSelectIndexPath.accept(nil)
            }else{
                self.diamondCollectionPaletteSelectIndexPath.accept(indexPath)
            }
            
            self.diamondCollectionPaletteDataArray.accept(sneDiamondItms)
            
            
        }).disposed(by: sneDisposeBag)
        
        diamondCollectionPaletteDataArray.accept(sneDiamondItms)
        
        diamondCollectionPaletteSelectIndexPath.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else {return}
            if indexPath != nil {
                self.recharegSneButton.isEnabled = true
            } else {
                self.recharegSneButton.isEnabled = false
            }
        }).disposed(by: sneDisposeBag)
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

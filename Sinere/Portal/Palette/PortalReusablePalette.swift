//
//  PortalReusablePalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class PortalReusablePalette: UICollectionReusableView {
    
    @IBOutlet weak var purPersiner: UIView!
    var sneMenuChanged:((Int)->())?
    var sneAIIndex:((Int)->())?
    
    var sneUserIndex:((Int)->())?

    @IBOutlet weak var protalAICollectionPalette: UICollectionView!
    @IBOutlet weak var protalMenuOne: UIButton!
    @IBOutlet weak var protalMenuTwo: UIButton!
    @IBOutlet weak var protalMenuThree: UIButton!
    @IBOutlet weak var protalUserCollectionPalette: UICollectionView!
    
    
    var sneTheOne:UIButton!
    
    private let protalReusableItems = BehaviorRelay<[(String,String)]>(value: [("AIstylepainting","AI style painting"),("AIpaintingoptimiza","AI painting optimiza")])
    private let sneDisposeBag = DisposeBag()
    
    let protalUserRelay = BehaviorRelay<[SneUserObject]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        purPersiner.layer.cornerRadius = 3
        purPersiner.layer.masksToBounds = true
        
        let sinerePortalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        sinerePortalCollectionViewFlowLayout.scrollDirection = .horizontal
        sinerePortalCollectionViewFlowLayout.minimumLineSpacing = 12
        sinerePortalCollectionViewFlowLayout.minimumInteritemSpacing = 12
        sinerePortalCollectionViewFlowLayout.itemSize = CGSizeMake(242,234)
        sinerePortalCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 12, right: 20)
        
        protalAICollectionPalette.setCollectionViewLayout(sinerePortalCollectionViewFlowLayout, animated: true)
        protalAICollectionPalette.register(UINib(nibName: "PortalReusableCellPalette", bundle: nil), forCellWithReuseIdentifier: "PortalReusableCellPalette")
        
        
        let portalUserLayout = UICollectionViewFlowLayout()
        portalUserLayout.scrollDirection = .horizontal
        portalUserLayout.minimumLineSpacing = 12
        portalUserLayout.minimumInteritemSpacing = 12
        portalUserLayout.itemSize = CGSizeMake(130,208)
        portalUserLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        protalUserCollectionPalette.setCollectionViewLayout(portalUserLayout, animated: true)
//        protalUserCollectionPalette.register(UINib(nibName: "PortalUserCellPalette", bundle: nil), forCellWithReuseIdentifier: "PortalUserCellPalette")
        
        protalUserCollectionPalette.register(UINib(nibName: "SineromeCell", bundle: nil), forCellWithReuseIdentifier: "SineromeCell")
        
        
        protalReusableItems.bind(to: protalAICollectionPalette.rx.items(cellIdentifier: "PortalReusableCellPalette", cellType: PortalReusableCellPalette.self)){ row, model, cell in
            cell.backgroundPalette.image = UIImage(named: model.0)
            cell.protalCellTitlePalette.text = model.1
        }.disposed(by: sneDisposeBag)
        
        protalAICollectionPalette.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let self = self {
                self.sneAIIndex?(indexPath.row)
            }
        }).disposed(by: sneDisposeBag)
        
        
        protalUserRelay.bind(to: protalUserCollectionPalette.rx.items(cellIdentifier: "SineromeCell", cellType: SineromeCell.self)){ row, model, cell in
            cell.rasomdnAvatoert.image = UIImage(named: model.profileThumbnail)
            cell.namePalette.text = model.sinereName
            
            cell.ltsVobert.image = UIImage(named: model.PicjRoomAcpic)
            cell.namePalette.text = model.PicjRoomTitle
        }.disposed(by: sneDisposeBag)
        
        protalUserCollectionPalette.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let self = self {
                self.sneUserIndex?(indexPath.row)
            }
        }).disposed(by: sneDisposeBag)
        
        
        sneTheOne = protalMenuOne
        
        protalMenuOne.setTitle("  " + "Tarwelnidqionpg".sinereString, for: .normal)
        protalMenuTwo.setTitle("  " + "Dwizsvceotvtelr".sinereString, for: .normal)
        protalMenuThree.setTitle("  " + "Fvozlyliojwmijneg".sinereString, for: .normal)
        protalMenuOne.titleLabel?.adjustsFontSizeToFitWidth = true
        protalMenuTwo.titleLabel?.adjustsFontSizeToFitWidth = true
        protalMenuThree.titleLabel?.adjustsFontSizeToFitWidth = true
        
        protalMenuOne.rx.tap.subscribe { [weak self] _ in
            guard let self = self else{return}
            
            self.portalMenuSelecte(protalMenu: self.protalMenuOne)
        }.disposed(by: sneDisposeBag)
        
        protalMenuTwo.rx.tap.subscribe { [weak self] _ in
            guard let self = self else{return}
            
            self.portalMenuSelecte(protalMenu: self.protalMenuTwo)
            
        }.disposed(by: sneDisposeBag)
        
        protalMenuThree.rx.tap.subscribe { [weak self] _ in
            guard let self = self else{return}
            
            self.portalMenuSelecte(protalMenu: self.protalMenuThree)
            
        }.disposed(by: sneDisposeBag)
        
    }
    
    private func portalMenuSelecte(protalMenu:UIButton){
        guard protalMenu != self.sneTheOne else {return}
        
        protalMenu.isSelected = true
        protalMenu.isUserInteractionEnabled = false
        protalMenu.backgroundColor = UIColor.init(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: 1)
        self.sneTheOne.isSelected = false
        self.sneTheOne.isUserInteractionEnabled = true
        self.sneTheOne.backgroundColor = .clear
        
        self.sneTheOne = protalMenu
        
        self.sneMenuChanged?(protalMenu.tag - 220)
    }
    
    
}

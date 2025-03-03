//
//  SinerePortalDetailHeaderPalette.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class SinerePortalDetailHeaderPalette: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var sinerePortalCollectionPalett: UICollectionView!
    
    
    @IBOutlet weak var interactionContent: UILabel!
    @IBOutlet weak var portalUserPalette: UIImageView!
    @IBOutlet weak var portalUserNaem: UILabel!
    
    @IBOutlet weak var portalUserFollowSneButton: UIButton!
    
    @IBOutlet weak var interactionImagesLabel: UILabel!
    
    var portalUserPaletteTaped = PublishSubject<Void>()
    
    let sneDisposeBag = DisposeBag()
    
    var sinerePortalDetail:SneUserObject?{
        didSet{
            if let _sinerePortalDetail = sinerePortalDetail {
                interactionContent.text = _sinerePortalDetail.interactionContent
                portalUserPalette.image = UIImage(named: _sinerePortalDetail.profileThumbnail)
                portalUserNaem.text = _sinerePortalDetail.sinereName
                interactionImagesLabel.text = "1/\(_sinerePortalDetail.interactionImages.count)"
                
                if SneTools.shareInfo.isSinereLogin(sneNmae: _sinerePortalDetail.sinereName) {
                    portalUserFollowSneButton.isHidden = true
                }else{
                    for mySneFollewer in SneTools.shareInfo.mySneFollewer {
                        if mySneFollewer.sinereName == _sinerePortalDetail.sinereName {
                            portalUserFollowSneButton.isSelected = true
                            break
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sinerePortalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        sinerePortalCollectionViewFlowLayout.minimumLineSpacing = 0
        sinerePortalCollectionViewFlowLayout.minimumInteritemSpacing = 0
        sinerePortalCollectionViewFlowLayout.itemSize = CGSizeMake(SneTools.sneWidthScreen - 24, 256)
        sinerePortalCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        sinerePortalCollectionViewFlowLayout.scrollDirection = .horizontal
        sinerePortalCollectionPalett.setCollectionViewLayout(sinerePortalCollectionViewFlowLayout, animated: true)
        sinerePortalCollectionPalett.delegate = self
        sinerePortalCollectionPalett.dataSource = self
        sinerePortalCollectionPalett.isPagingEnabled = true
        sinerePortalCollectionPalett.register(SinerePortalCollectionCellPalette.self, forCellWithReuseIdentifier: "SinerePortalCollectionCellPalette")
        
        let portalUserPaletteTapGesture = UITapGestureRecognizer(target: self, action: #selector(portalUserPaletteTapGestureRecognizer))
        portalUserPalette.isUserInteractionEnabled = true
        portalUserPalette.addGestureRecognizer(portalUserPaletteTapGesture)
        
        NotificationCenter.default.rx.notification(Notification.Name("sneFollerStateChange")).subscribe(onNext: { [weak self] _ in
            guard let self = self else {return}
            var isSneFolled = false
            for mySneFollewer in SneTools.shareInfo.mySneFollewer {
                if mySneFollewer.sinereName == self.sinerePortalDetail?.sinereName {
                    isSneFolled = true
                    break
                }
            }
            self.portalUserFollowSneButton.isSelected = isSneFolled
        }).disposed(by: sneDisposeBag)
    }
    
    @objc func portalUserPaletteTapGestureRecognizer(){
        portalUserPaletteTaped.onNext(())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sinerePortalDetail == nil ? 0 : sinerePortalDetail!.interactionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sinerePortalCollectionCellPalette = collectionView.dequeueReusableCell(withReuseIdentifier: "SinerePortalCollectionCellPalette", for: indexPath) as! SinerePortalCollectionCellPalette
        let interactionImages = sinerePortalDetail!.interactionImages
        sinerePortalCollectionCellPalette.sneFullImagePalette.image = UIImage(named: interactionImages[indexPath.row])
        return sinerePortalCollectionCellPalette
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sneOffsetXPage = Int(scrollView.contentOffset.x / (SneTools.sneWidthScreen-24)) + 1
        interactionImagesLabel.text = "\(sneOffsetXPage)/\(sinerePortalDetail!.interactionImages.count)"
    }
}


class SinerePortalCollectionCellPalette : UICollectionViewCell {
    
    var sneFullImagePalette:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sneFullImagePalette = UIImageView()
        sneFullImagePalette.contentMode = .scaleAspectFill
        sneFullImagePalette.layer.cornerRadius = 16
        sneFullImagePalette.layer.masksToBounds = true
        self.contentView.addSubview(sneFullImagePalette)
        sneFullImagePalette.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



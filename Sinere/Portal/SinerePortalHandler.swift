

import UIKit
import RxSwift
import RxCocoa

class SinerePortalHandler: CreativeBaseHandler,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var imaginariumHandler = false
    
    var showLoading = true
    
    @IBOutlet weak var sinerePortalCollectionView: UICollectionView!
    let disposeBag = DisposeBag()

    var sinerePortalCollectionViewDatas = [SneUserObject]()
    
    var sinerePortalCollectionViewDatasindex:SneUserObject?
    
    var portalUserDatas = [SneUserObject]()
    
    var portalUser:SneUserObject!
    
    var portalMenuIndex = 0{
        didSet{
            self.showLoading = true
            getAllPortalDatas()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func instantRelayButton(_ sender: Any) {
        self.performSegue(withIdentifier: "InstantRelayListHandler", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sinerePortalCollectionViewFlowLayout = UICollectionViewFlowLayout()
        sinerePortalCollectionViewFlowLayout.minimumLineSpacing = 12
        sinerePortalCollectionViewFlowLayout.minimumInteritemSpacing = 12
        sinerePortalCollectionViewFlowLayout.itemSize = CGSizeMake((SneTools.sneWidthScreen - 36) / 2, 273)
        sinerePortalCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: SneTools.sneSafeBottom + 100, right: 12)
        sinerePortalCollectionView.setCollectionViewLayout(sinerePortalCollectionViewFlowLayout, animated: true)
        sinerePortalCollectionView.delegate = self
        sinerePortalCollectionView.dataSource = self
        sinerePortalCollectionView.register(UINib(nibName: "PortalReusablePalette", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "PortalReusablePalette")
        
        
        NotificationCenter.default.rx.notification(Notification.Name("getAllPortalDatas")).subscribe {[weak self] _ in
            guard let self = self else {return}
            self.getAllPortalDatas()
        }.disposed(by: sneDisposeBag)
        
        getAllPortalDatas()
    }
    
    
    fileprivate func getAllPortalDatas(){
        if showLoading {
            self.view.makeToastActivity(.center)
        }
        DispatchQueue.global(qos: .background).async {
            sleep(UInt32(1.5))
            
            let portalTempSneArray = SneTools.shareInfo.sneArtboarObjectArray
            var sneportalTempArray:[SneUserObject] = []
            var portalUserDatas:[SneUserObject] = []
            portalTempSneArray.forEach { sneUserObject in
                var sneUserObjectInArray = false
                SneTools.shareInfo.myShieldPortal.forEach { toolSneUserObject in
                    if sneUserObject.id == toolSneUserObject.id {
                        sneUserObjectInArray = true
                    }
                }
                
                if sneUserObjectInArray == false {
                    SneTools.shareInfo.myShieldUser.forEach { toolSneUserObject in
                        if sneUserObject.id == toolSneUserObject.id {
                            sneUserObjectInArray = true
                        }
                    }
                }
                
                if SneTools.shareInfo.sneCurrentUser.value != nil && self.portalMenuIndex == 2 && sneUserObjectInArray == false{
                    SneTools.shareInfo.mySneFollewer.forEach { toolSneUserObject in
                        if sneUserObject.sinereName == toolSneUserObject.sinereName {
                            sneportalTempArray.append(sneUserObject)
                        }
                    }
                    portalUserDatas.append(sneUserObject)
                }else{
                    if sneUserObjectInArray == false {
                        sneportalTempArray.append(sneUserObject)
                        portalUserDatas.append(sneUserObject)
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                if self.showLoading{
                    self.view.hideToastActivity()
                    sneportalTempArray.shuffle()
                    portalUserDatas.shuffle()
                }
                self.sinerePortalCollectionViewDatas = sneportalTempArray
                self.portalUserDatas = portalUserDatas
                self.sinerePortalCollectionView.reloadData()
                self.showLoading = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sneIdentifier = segue.identifier
        if sneIdentifier == "ImaginariumHandler"{
            if let imaginariumHandler = segue.destination as? ImaginariumHandler {
                imaginariumHandler.isSneAiStylePaint = self.imaginariumHandler
            }
        }
        
        if sneIdentifier == "SinerePortalHandlerDetailHandler"{
            if let sinerePortalHandlerDetailHandler = segue.destination as? SinerePortalHandlerDetailHandler {
                sinerePortalHandlerDetailHandler.sinerePortalDetail = sinerePortalCollectionViewDatasindex
            }
        }
        
        if sneIdentifier == "MySpaceHandler"{
            if let mySpaceHandler = segue.destination as? MySpaceHandler {
                mySpaceHandler.spaceUserObject = self.portalUser
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SneTools.sneWidthScreen, height: 452)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let portalCellPalette = collectionView.dequeueReusableCell(withReuseIdentifier: "PortalCellPalette", for: indexPath) as! PortalCellPalette
        portalCellPalette.portalImagePalette.image = UIImage(named: sinerePortalCollectionViewDatas[indexPath.row].interactionImages.first!)
        portalCellPalette.portalUserPalette.image = UIImage(named: sinerePortalCollectionViewDatas[indexPath.row].profileThumbnail)
        portalCellPalette.protalCaption.text = sinerePortalCollectionViewDatas[indexPath.row].interactionContent
        portalCellPalette.portalusernaem.text = sinerePortalCollectionViewDatas[indexPath.row].sinereName
        return portalCellPalette
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let protalHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PortalReusablePalette", for: indexPath) as! PortalReusablePalette
            protalHeader.protalUserRelay.accept(portalUserDatas)
            protalHeader.sneMenuChanged = { [weak self] value in
                guard let self = self else {return}
                self.portalMenuIndex = value
            }
            
            protalHeader.sneAIIndex = {[weak self] value in
                if let self = self {
                    self.imaginariumHandler = value == 0
                    self.performSegue(withIdentifier: "ImaginariumHandler", sender: self)
                }
            }
            
            protalHeader.sneUserIndex = {[weak self] value in
                if let self = self {
                    
                    self.portalUser = self.portalUserDatas[value]
                    if SneTools.shareInfo.isSinereLogin(sneNmae: self.portalUser.sinereName) {
                        NotificationCenter.default.post(name: NSNotification.Name("tabbarSelectChange"), object: ["index":1]);
                    }else{
                        self.performSegue(withIdentifier: "MySpaceHandler", sender: self)
                    }
                }
            }
            
            return protalHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sinerePortalCollectionViewDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sinerePortalCollectionViewDatasindex = self.sinerePortalCollectionViewDatas[indexPath.row]
        self.performSegue(withIdentifier: "SinerePortalHandlerDetailHandler", sender: self)
    }
    
}


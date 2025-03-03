//
//  SinerePortalHandlerDetailHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import UIKit


class SinerePortalHandlerDetailHandler: CreativeBaseHandler,UITableViewDelegate,UITableViewDataSource {
    
    var sinerePortalDetail:SneUserObject!
    
    @IBOutlet weak var portalCommandTextField: UITextField!
    fileprivate var portalDetailConmentDataArray:[String]?

    @IBOutlet weak var portalDetailTablePalett: UITableView!
    
    @IBOutlet weak var portalLikeButton: UIButton!
    private var portalDetailTablePalettHeader:SinerePortalDetailHeaderPalette?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: 0)
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        portalDetailTablePalettHeader = Bundle.main.loadNibNamed("SinerePortalDetailHeaderPalette", owner: nibName, options: nil)?.first as? SinerePortalDetailHeaderPalette
        portalDetailTablePalett.frame = CGRectMake(0, 0, SneTools.sneWidthScreen, 531)
        portalDetailTablePalett.tableHeaderView = portalDetailTablePalettHeader
        if portalDetailTablePalettHeader != nil {
            portalDetailTablePalettHeader!.sinerePortalDetail = self.sinerePortalDetail
            portalDetailTablePalettHeader!.portalUserFollowSneButton.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.view.makeToastActivity(.center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.view.hideToastActivity()
                    self.portalDetailTablePalettHeader?.portalUserFollowSneButton.isSelected.toggle()
                    if var sneUser = SneTools.shareInfo.sneCurrentUser.value {
                        if self.portalDetailTablePalettHeader?.portalUserFollowSneButton.isSelected == true {
                            SneTools.shareInfo.mySneFollewer.append(self.sinerePortalDetail)
                            sneUser.sinereFollower += 1
                        }else{
                            SneTools.shareInfo.mySneFollewer.removeAll { SneUserObject in
                                SneUserObject.sinereName == self.sinerePortalDetail.sinereName
                            }
                            sneUser.sinereFollower -= 1
                        }
                        SneTools.shareInfo.sneCurrentUser.accept(sneUser)
                    }
                    
                }
            }).disposed(by: sneDisposeBag)
            
            portalDetailTablePalettHeader!.portalUserPaletteTaped.subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                if SneTools.shareInfo.isSinereLogin(sneNmae: self.sinerePortalDetail.sinereName) {
                    NotificationCenter.default.post(name: NSNotification.Name("tabbarSelectChange"), object: ["index":1]);
                    self.navigationController?.popViewController(animated: false)
                }else{
                    self.performSegue(withIdentifier: "MySpaceHandler", sender: self)
                }
            }).disposed(by: sneDisposeBag)
        }
        
        let itemClick = { [weak self] in
            guard let self = self else {return}
            self.presentActionSheet()
        }
        
        sinereRightButtonItems(imageNames: ["sinereDetailComplain"], buttonClicks: [itemClick])
        
        for mySneLiked in SneTools.shareInfo.mySneLiked {
            if mySneLiked.id == sinerePortalDetail.id {
                portalLikeButton.isSelected = true
                break
            }
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
                    SneTools.shareInfo.myShieldPortal.append(self.sinerePortalDetail)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sinereOffsetY = scrollView.contentOffset.y
        let alpha = min(1, max(0, sinereOffsetY / 150))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: alpha)
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let portalDetailEmptyCellPalette = tableView.dequeueReusableCell(withIdentifier: "PortalDetailEmptyCellPalette") as! PortalDetailEmptyCellPalette
        return portalDetailEmptyCellPalette
    }
    
    @IBAction func portalDetailLiked(_ sender: UIButton) {
        self.view.makeToastActivity(.center)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view.hideToastActivity()
            sender.isSelected.toggle()
            
            if sender.isSelected == true {
                SneTools.shareInfo.mySneLiked.append(self.sinerePortalDetail)
            }else{
                SneTools.shareInfo.mySneLiked.removeAll { sneUserObject in
                    sneUserObject.id == self.sinerePortalDetail.id
                }
            }
        }
    }
    
    @IBAction func sendPortalCommand(_ sender: UIButton) {
        if let text = portalCommandTextField.text ,text.count > 0 {
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.view.hideToastActivity()
                self.view.makeToast("Tihvalnnkh gybodus lfjolrw wyfovuprv ecaodmcmaeanctk,w ttdhoep kpplragtffnoirmmy xwwiilelt zrmesvsioekws dixtv lwqictkheilnq b2i4e phmoauoris".sinereString,position: .center)
                self.portalCommandTextField.text = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portalDetailConmentDataArray != nil ? portalDetailConmentDataArray!.count : 1
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        MySpaceHandler
        let sneIdentifier = segue.identifier
        if sneIdentifier == "MySpaceHandler"{
            if let mySpaceHandler = segue.destination as? MySpaceHandler {
                mySpaceHandler.spaceUserObject = self.sinerePortalDetail
            }
        }
    }

}

class PortalDetailEmptyCellPalette : UITableViewCell{
    
}

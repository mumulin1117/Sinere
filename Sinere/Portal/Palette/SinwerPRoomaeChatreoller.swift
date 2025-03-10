//
//  SinwerPRoomaeChatreoller.swift
//  Sinere
//
//  Created by Sinere on 2025/3/7.
//

import UIKit

class SinwerPRoomaeChatreoller:  CreativeBaseHandler ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var minloly: UIImageView!
    
    @IBOutlet weak var minEuoi: UILabel!
    
    
    
    
    @IBOutlet weak var romakerTItle: UILabel!
    var isMyCreate:(Bool,String) = (false,"")
    var minobjexct:SneUserObject?
    @IBAction func raiResliHDjser(_ sender: UIButton) {
        if isMyCreate.0 == true {
            let aldertBvc = UIAlertController.init(title: "Leave and destroy?", message: "After the creator leaves the room, the room will be destroyed by the system", preferredStyle: .alert)
            aldertBvc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            aldertBvc.addAction(UIAlertAction(title: "Sure", style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            
            self.present(aldertBvc, animated: true)
            
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var onLinadsinCOunt: UILabel!
    
    
    
  
        @IBOutlet weak var instantRelayListTablePalette: UITableView!

        @IBOutlet weak var sneUserImagePaleete: UIImageView!
        @IBOutlet weak var sneUserNamePaleete: UILabel!
        @IBOutlet weak var sneMessageEditField: UITextField!
        
        var spaceUserObject:SneUserObject?
        
        var instantRelayTableDataArray = [InstantRelayObject]()
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
        override func viewDidLoad() {
            super.viewDidLoad()
            sneUserImagePaleete.layer.cornerRadius = 29
            sneUserImagePaleete.layer.masksToBounds = true
            minloly.layer.cornerRadius = 29
            minloly.layer.masksToBounds = true
            
           
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: DispatchWorkItem(block: {
                self.view.hideToastActivity()
                
                if self.isMyCreate.0 == false{
                    SneTools.shareInfo.RoomRelayObjectArray.forEach { _instantRelayObject in
                        
                        if _instantRelayObject.instantRelayRemoteUser == self.spaceUserObject?.sinereName ?? "" {
                            self.instantRelayTableDataArray.append(_instantRelayObject)
                            
                            self.instantRelayListTablePalette.reloadData()
                        }
                    }
                    
                }
               
            }))
            
            instantRelayListTablePalette.register(SinwerRooTalkCell.self, forCellReuseIdentifier: "SinwerRooTalkCell")
            
            instantRelayListTablePalette.rowHeight = UITableView.automaticDimension
            instantRelayListTablePalette.estimatedRowHeight = 150
            instantRelayListTablePalette.delegate = self
            instantRelayListTablePalette.dataSource = self
       
            sneUserImagePaleete.layer.borderWidth = 2
            sneUserImagePaleete.layer.borderColor = UIColor(red: 0.72, green: 0.34, blue: 0.92, alpha: 1).cgColor
            
            if isMyCreate.0 == false{
                
                if let _spaceUserObject = self.spaceUserObject {
                    sneUserImagePaleete.image = UIImage(named: _spaceUserObject.profileThumbnail)
                    sneUserNamePaleete.text = _spaceUserObject.sinereName
                    romakerTItle.text = _spaceUserObject.PicjRoomTitle
                }
                
                SneTools.shareInfo.sneCurrentUser.subscribe(onNext: {[weak self] sneCurrentUser in
                    guard let self = self else {return}
                    self.minobjexct = sneCurrentUser
                    minloly.image = UIImage(named: minobjexct?.profileThumbnail ?? "")
                    
                    minEuoi.text = "Me"
                }).disposed(by: sneDisposeBag)
                
            }else{
                
                minloly.isHidden = true
                minEuoi.isHidden = true
                onLinadsinCOunt.text = "1 onlins"
                SneTools.shareInfo.sneCurrentUser.subscribe(onNext: {[weak self] sneCurrentUser in
                    guard let self = self else {return}
                    self.minobjexct = sneCurrentUser
                    sneUserNamePaleete.text = "Me"
                    sneUserImagePaleete.image = UIImage(named: minobjexct?.profileThumbnail ?? "")
                    romakerTItle.text = isMyCreate.1
                    
                    
                }).disposed(by: sneDisposeBag)
               
            }
           
            
           
            
           
            
        }
        
    @IBAction   func presentActionSheet() {
        let aldertBvc = UIAlertController.init(title: "Report Chat Room?", message: "Please select the reason for reporting?", preferredStyle: .alert)
        
        let AllReadong = ["Harassment or Bullying","Spam or Scam","Inappropriate Content","Other Reason"]
        AllReadong.forEach { Titielt in
            aldertBvc.addAction(UIAlertAction(title: Titielt, style: .default, handler: { action in
                self.view.makeToastActivity(.center)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: DispatchWorkItem(block: {
                    self.view.hideToastActivity()
                    self.view.makeToast("The report has been submitted successfully, and we will review and process it as soon as possible",position: .center)
                }))
            }))
        }
        
        aldertBvc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        self.present(aldertBvc, animated: true)
        

       
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
                    SneTools.shareInfo.RoomRelayObjectArray.append(instantRelayObject)
                    
                    self.instantRelayListTablePalette.reloadData()
                    
//                    SneTools.shareInfo.instantRelayListObjectArray.removeAll { _instantRelayListObject in
//                        _instantRelayListObject.instantRelayRemoteUser == self.spaceUserObject?.sinereName ?? ""
//                    }
                    
//                    SneTools.shareInfo.RoomRelayObjectArray.insert(InstantRelayListObject(instantRelayObject: instantRelayObject), at: 0)
                    sneMessageEditField.text = ""
                    return
                }
                
                self.view.makeToast("The sent content cannot be empty",position: .center)
            }
        }
        
      
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return instantRelayTableDataArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let instantRelayListContentCell = tableView.dequeueReusableCell(withIdentifier: "SinwerRooTalkCell") as! SinwerRooTalkCell
           
            let instantRelayObject = instantRelayTableDataArray[indexPath.row]
            instantRelayListContentCell.CrongchatingVi.text = instantRelayObject.instantRelayMessage
           
            return instantRelayListContentCell
        }
        
     
        
    }


class SinwerRooTalkCell: UITableViewCell {
    
    lazy var CrongchatingVi: UILabel = {
        let siner = UILabel.init()
       
        siner.textAlignment = .right
        siner.font = UIFont(name: "HarmonyOS Sans", size: 14)
        return siner
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        chuangjiKoan()
        self.backgroundColor = .clear
       
        
        let adjnhubug = UIView.init()
        adjnhubug.backgroundColor = .white
        adjnhubug.layer.cornerRadius = 25
        
        adjnhubug.layer.masksToBounds = true
        contentView.addSubview(adjnhubug)
        contentView.addSubview(CrongchatingVi)
        CrongchatingVi.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(32)
            make.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-32)
            make.width.lessThanOrEqualTo(234)
        }
        
        adjnhubug.snp.makeConstraints { make in
            make.left.equalTo(CrongchatingVi.snp.left).offset(-16)
            make.right.equalTo(CrongchatingVi.snp.right).offset(16)
            make.top.equalTo(CrongchatingVi).offset(-16)
            make.bottom.equalTo(CrongchatingVi).offset(16)
        }
        
        
    }
    
    private func chuangjiKoan()  {
        CrongchatingVi.textColor = .black
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

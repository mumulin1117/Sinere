//
//  InstantRelayListHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class InstantRelayListHandler: CreativeBaseHandler,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var instantRelayTablePalette: UITableView!
    
    var instantRelayTableDataArray = [InstantRelayListObject]()
    
    var sneUserObject:SneUserObject?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        instantRelayTableDataArray = SneTools.shareInfo.instantRelayListObjectArray
        instantRelayTablePalette.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Muedsrskenaigye".sinereString
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return instantRelayTableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instantRelayListObject = instantRelayTableDataArray[indexPath.row]
        sneUserObject = SneUserObject()
        sneUserObject?.sinereName = instantRelayListObject.instantRelayRemoteUser
        sneUserObject?.profileThumbnail = instantRelayListObject.instantRelayRemoteUser + ".jpg"
        self.performSegue(withIdentifier: "InstantRelayListContentHandler", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instantRelayListCell = tableView.dequeueReusableCell(withIdentifier: "InstantRelayListCell") as! InstantRelayListCell
        let instantRelayListObject = instantRelayTableDataArray[indexPath.row]
        instantRelayListCell.senUserImagePalette.image = UIImage(named: instantRelayListObject.instantRelayRemoteUser + ".jpg")
        instantRelayListCell.sneUserNamepalettr.text = instantRelayListObject.instantRelayRemoteUser
        instantRelayListCell.sneInstantRelay.text = instantRelayListObject.instantRelayMessage
        
        return instantRelayListCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sneIdentifier = segue.identifier
        
        if sneIdentifier == "InstantRelayListContentHandler"{
            if let instantRelayListContentHandler = segue.destination as? InstantRelayListContentHandler {
                instantRelayListContentHandler.spaceUserObject = self.sneUserObject
            }
        }
    }

}


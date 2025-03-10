//
//  SinwerPubPickController.swift
//  Sinere
//
//  Created by  on 2025/3/7.
//

import UIKit

class SinwerPubPickController: UIViewController {
    
    @IBOutlet weak var dymNiuy: UIImageView!
    @IBOutlet weak var dymroomNiuy: UIImageView!
    
    
    @IBOutlet weak var dymNiuyLabel: UILabel!
    @IBOutlet weak var dymroomLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        dymNiuy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(taptoupupokill(tibert: ))))
        dymroomNiuy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(taptoupupokill(tibert: ))))
        dymNiuyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(taptoupupokill(tibert: ))))
        dymroomLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(taptoupupokill(tibert: ))))
    }


    @IBAction func sinkkiStart(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
   
    
    @objc func taptoupupokill(tibert:UITapGestureRecognizer)  {
        let taplvires = tibert.view
        if taplvires == dymNiuy ||  taplvires == dymNiuyLabel{
            //发布动态
           
           
            if let sketNotesHandler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SketNotesHandler") as? SketNotesHandler {
//                let sneChild = self.children[self.sneItemClick.value]
                self.navigationController?.pushViewController(sketNotesHandler, animated: true)
            }
        }
        
        if taplvires == dymroomNiuy ||  taplvires == dymroomLabel{
            //发布room
            self.navigationController?.pushViewController(SinwerPRoomaerhandontroller.init(), animated: true)
            
        }
    }

}

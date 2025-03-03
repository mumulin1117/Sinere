//
//  InspireStation.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit
import RxSwift
import RxCocoa

class InspireStationHandler: UIViewController {

    @IBOutlet weak var SnePortalButton: UIButton!
    @IBOutlet weak var SneSpaceButton: UIButton!
    
    @IBOutlet weak var SneSparkPadButton: UIButton!
    
    @IBOutlet weak var menuPalette: UIView!
    
    let sneDisposeBag = DisposeBag()
    
    let sneItemClick = BehaviorRelay<Int>(value: 0)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let sinerePortalHandler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SinerePortalHandler")
        let mySpaceHandler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySpaceHandler")
        
        sinerePortalHandler.view.frame = self.view.bounds
        mySpaceHandler.view.frame = self.view.bounds
        
        self.view.addSubview(sinerePortalHandler.view)
        self.view.addSubview(mySpaceHandler.view)
        
        self.addChild(sinerePortalHandler)
        self.addChild(mySpaceHandler)
        
        self.view.bringSubviewToFront(self.menuPalette)
        
        linkBrushPath()
    }
    
    private func linkBrushPath(){
        
        sneItemClick.subscribe { [weak self] _sneItemClick  in
            guard let self = self else {return}
            if _sneItemClick == 0 {
                self.SnePortalButton.isSelected = true
                self.SnePortalButton.isUserInteractionEnabled = false
                self.SneSpaceButton.isSelected = false
                self.SneSpaceButton.isUserInteractionEnabled = true
                var sneChild:UIViewController = self.children[_sneItemClick]
                sneChild.view.isHidden = false
                
                sneChild = self.children[1]
                sneChild.view.isHidden = true
            }else{
                self.SneSpaceButton.isSelected = true
                self.SneSpaceButton.isUserInteractionEnabled = false
                self.SnePortalButton.isSelected = false
                self.SnePortalButton.isUserInteractionEnabled = true
                
                var sneChild:UIViewController = self.children[_sneItemClick]
                sneChild.view.isHidden = false
                
                sneChild = self.children[0]
                sneChild.view.isHidden = true
            }
        }.disposed(by: sneDisposeBag)
        
        SnePortalButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.sneItemClick.accept(0)
        }.disposed(by: sneDisposeBag)
        
        SneSpaceButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.sneItemClick.accept(1)
        }.disposed(by: sneDisposeBag)
        
        SneSparkPadButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
           
            if let sketNotesHandler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SketNotesHandler") as? SketNotesHandler {
                let sneChild = self.children[self.sneItemClick.value]
                sneChild.navigationController?.pushViewController(sketNotesHandler, animated: true)
            }
            
        }.disposed(by: sneDisposeBag)
        
        NotificationCenter.default.rx.notification(NSNotification.Name("tabbarSelectChange")).subscribe(onNext: { [weak self] notification in
            guard let self = self else {return}
            if let sneNotificationObject = notification.object as? [String:Int] {
                if let sneSeleIndex = sneNotificationObject["index"] {
                    self.sneItemClick.accept(sneSeleIndex)
                }
            }
        }).disposed(by: sneDisposeBag)
    }
    

}

//
//  AboutSinereHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit
import RxSwift
import RxCocoa

class AboutSinereHandler: CreativeBaseHandler {
    
    @IBOutlet weak var sinereDisplayName: UILabel!
    @IBOutlet weak var SinereVersion: UILabel!
    @IBOutlet weak var sinereDescript: UILabel!
    
    let SneTextRelay = BehaviorRelay<String>(value: "")
    let SneVersion = BehaviorRelay<String>(value: "")
    let sneCFBundleDisplayName = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        SneTextRelay.bind(to: sinereDescript.rx.text).disposed(by: sneDisposeBag)
        SneVersion.bind(to: SinereVersion.rx.text).disposed(by: sneDisposeBag)
        sneCFBundleDisplayName.bind(to: sinereDisplayName.rx.text).disposed(by: sneDisposeBag)
        
        let textDescript =
        """
        Welcome to Sinere, built for people who love painting! Here, you can not only show your artistic talent, but also build deep connections with other art lovers.
        
        Main features:
        
        AI style painting generation: Using advanced AI technology, you can choose your favorite style and easily create unique works of art.
        
        AI painting optimization: You can improve your creations through our AI optimization function.
        
        Community function: Join our vibrant art community and share your works and creativity with other painting enthusiasts.
        
        Whether you are a painting beginner or a professional artist, this is an ideal platform for you to show your talent, get inspiration and make friends. Download Sinere and start your artistic exploration journey!
        """
        
        SneTextRelay.accept(textDescript)
        
        let CFBundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        if let CFBundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? CFBundleName {
            sneCFBundleDisplayName.accept(CFBundleDisplayName)
        }
        
        
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            SneVersion.accept("Vregrrsribotn".sinereString + " " + appVersion)
        }
        

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

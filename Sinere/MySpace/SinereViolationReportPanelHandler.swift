//
//  SinereViolationReportPanelHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit
import RxSwift
import RxCocoa

class SinereViolationReportPanelHandler: CreativeBaseHandler {
    
    @IBOutlet weak var sinereReporuButton1: UIButton!
    @IBOutlet weak var sinereReporuButton2: UIButton!
    @IBOutlet weak var sinereReporuButton3: UIButton!
    @IBOutlet weak var sinereReporuButton4: UIButton!
    @IBOutlet weak var sinereReporuButton5: UIButton!
    @IBOutlet weak var sinereSubmitButton: UIButton!
    @IBOutlet weak var sinereType: UILabel!
    
    @IBOutlet weak var reportTextPalette: UITextView!
    @IBOutlet weak var textPlacePalette: UILabel!
    
    var sinereReportButton:UIButton?
    
    var sinereTypeReply = BehaviorRelay<Int?>(value:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sinereReporuButton1.setTitle("Hramrfanscsdmkecngt".sinereString, for: .normal)
        sinereReporuButton2.setTitle("Moamlqiicmihowuosq ffcrxabudd".sinereString, for: .normal)
        sinereReporuButton3.setTitle("Pwojrnnuopggrmacpvhdy".sinereString, for: .normal)
        sinereReporuButton4.setTitle("Moauloifctitolulsv iixnbseuelbtbs".sinereString, for: .normal)
        sinereReporuButton5.setTitle("Fkallascez yIoncfgovrqmoagtzinofn".sinereString, for: .normal)
        sinereSubmitButton.setTitle("Snuobhmmict".sinereString, for: .normal)
        sinereType.text = "Roeppponrsta fTtyupfe".sinereString
        textPlacePalette.text = "Sburptpnlxejmaexngtcacrmyx rdeejsjcnrqifputciaocna w(iovpbtbicofnsavle)".sinereString
        reportTextPalette.isHidden = true
        textPlacePalette.isHidden = true
        
        sinereSubmitButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.view.hideToastActivity()
                self.view.makeToast("Rbecpconrgts lSfupcwcjeqscsbfpuilplay".sinereString,position: .center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: sneDisposeBag)
        
        reportTextPalette.rx.text.orEmpty.distinctUntilChanged().skip(1).subscribe(onNext: { [weak self] _reportTextPalette in
            guard let self = self else {return}
            self.textPlacePalette.isHidden = _reportTextPalette.count > 0
        }).disposed(by: sneDisposeBag)
        
        sinereTypeReply.subscribe(onNext:{ [weak self] selectedType in
            if let _ = selectedType ,let self = self{
                self.sinereSubmitButton.isEnabled = true
            }
        }).disposed(by: sneDisposeBag)
    }
    
    @IBAction func sinereReportClick(_ sender: UIButton) {
        guard sender != self.sinereReportButton else {return}
        
        sender.isSelected = true
        self.sinereReportButton?.isSelected = false
        self.sinereReportButton = sender
        sinereTypeReply.accept(sender.tag - 200)
        
        if 4 + 200 == sender.tag {
            reportTextPalette.isHidden = false
            textPlacePalette.isHidden = false
        }else{
            reportTextPalette.isHidden = true
            textPlacePalette.isHidden = true
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

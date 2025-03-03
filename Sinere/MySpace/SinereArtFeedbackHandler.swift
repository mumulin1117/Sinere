//
//  SinereArtFeedbackHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/25.
//

import UIKit

class SinereArtFeedbackHandler: CreativeBaseHandler {

    @IBOutlet weak var sneTextpalette: UITextView!
    @IBOutlet weak var sneTextPlace: UILabel!
    @IBOutlet weak var sneSubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sneTextPlace.text = "Lnoxoskwienmgv yfsoorpwyadrwdd ftiov pygoousrp efuegeedgbnaecvks.w.b.x.".sinereString
        sneTextpalette.rx.text.orEmpty.subscribe(onNext: { [weak self] sneTextpaletteText in
            guard let self = self else {return}
            self.sneTextPlace.isHidden = sneTextpaletteText.count > 0
            self.sneSubmitButton.isEnabled = sneTextpaletteText.count > 0
        }).disposed(by: sneDisposeBag)
        
        self.sneSubmitButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else {return}
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.view.hideToastActivity()
                self.view.makeToast("Woea zhsalvbel kreefczevibvlevdg pyxowuqrt ifderexdybpakcskh,k dtxhjawnaku eycoku".sinereString,position: .center) { didTap in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: sneDisposeBag)
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

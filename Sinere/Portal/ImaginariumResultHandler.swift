//
//  ImaginariumResultHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import BBWebImage
import Photos

class ImaginariumResultHandler: CreativeBaseHandler {

    @IBOutlet weak var sneResultDownloadButton: UIButton!
    @IBOutlet weak var sneResultSaveButton: UIButton!
    @IBOutlet weak var sneWantKeywords: UILabel!
    @IBOutlet weak var sneResultImagePalette: UIImageView!
    
    var sneDownResultImage:UIImage?
    
    var sneInputText:String!
    var smeResultImageAddress:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Glexnkemrjaitden hrteyscuwlitos".sinereString
        sneResultDownloadButton.layer.borderColor = UIColor.init(red: 184/255.0, green: 87/255.0, blue: 234/255.0, alpha: 1).cgColor
        sneResultDownloadButton.layer.borderWidth = 1
        sneResultDownloadButton.layer.cornerRadius = 24
        sneResultDownloadButton.layer.masksToBounds = true
        self.sneResultDownloadButton.isHidden = true
        self.sneResultSaveButton.isHidden = true
        
        sneWantKeywords.text = self.sneInputText
        
        if let sneImageAddress = smeResultImageAddress,let sneImageUrl = URL(string: sneImageAddress) {
            self.view.makeToastActivity(.center)
            sneResultImagePalette.bb_setImage(with: sneImageUrl,
                                              options: .progressiveDownload, completion:
                                                { (image: UIImage?, data: Data?, error: Error?, cacheType: BBImageCacheType) in
                if let sneResultImage = image {
                    DispatchQueue.main.async {
                        self.sneDownResultImage = sneResultImage
                        self.view.hideToastActivity()
                        self.sneResultDownloadButton.isHidden = false
                        self.sneResultSaveButton.isHidden = false
                    }
                }
            })
        }
        
        sneResultDownloadButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.view.hideToastActivity()
                PHPhotoLibrary.requestAuthorization { requestSneStatus in
                    if requestSneStatus == .authorized {
                        DispatchQueue.global(qos: .background).async {
                            
                            if let _changedImage = self.sneDownResultImage {
                                if let _ = _changedImage.jpegData(compressionQuality: 1.0) {
                                    PHPhotoLibrary.shared().performChanges({
                                        PHAssetChangeRequest.creationRequestForAsset(from: _changedImage)
                                    }, completionHandler: { success, error in
                                        DispatchQueue.main.async {
                                            if success {
                                                self.view.makeToast("Dtoawenulforazdz vStupcscvevsls".sinereString,position: .center)
                                            } else {
                                                self.view.makeToast("Dcoswynslzouaodd dfiaqijlxegd".sinereString,position: .center)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.view.makeToast("Pclgeharsqex ptvuqrfnl fownf htbhveq wpzhdoetjoe wajltbrusmz epkecrhmwixseshisogng jione ltvhlef bsneotmtqirnlghs".sinereString,position: .center)
                        }
                    }
                }
            }
            
            
        }.disposed(by: sneDisposeBag)
        
        sneResultSaveButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else {return}
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.view.hideToastActivity()
                self.view.makeToast("Scaqvwerdm nsmusclcaewsksofuujlclry".sinereString, position: .center)
            }
        }.disposed(by: sneDisposeBag)
        
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

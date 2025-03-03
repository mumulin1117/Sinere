//
//  SketNotesHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/21.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa

class SketNotesHandler: CreativeBaseHandler,PHPickerViewControllerDelegate {
    
    @IBOutlet weak var sinereTopTips: UILabel!
    @IBOutlet weak var sinereSelectImagePaleete: UIImageView!
    @IBOutlet weak var sketNotesReleaseButton: UIButton!
    @IBOutlet weak var sketNotesTextPalette: UITextView!
    @IBOutlet weak var sketPlaceHolderTip: UILabel!
    
    let sneSelectedImagePalette = BehaviorRelay<UIImage?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 4/255.0, green: 6/255.0, blue: 32/255.0, alpha: 1)
        sinereTopTips.text = "Cnompgycwjrjiwtbeer".sinereString
        sketNotesReleaseButton.setTitle("Rzejlneeafsme".sinereString, for: .normal)
        
        sketPlaceHolderTip.text = "Pclfeiaxsmez nexndtjeyr".sinereString
        
        sketNotesTextPalette.rx.text.orEmpty.subscribe { [weak self] sketNotesTextPaletteText in
            guard let self = self else {return}
            self.sketPlaceHolderTip.isHidden = sketNotesTextPaletteText.count > 0
        }.disposed(by: sneDisposeBag)
        let sinereSelectImagePaleeteTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sinereSelectImagePaleeteTapGestureRecognizerSelector))
        sinereSelectImagePaleete.isUserInteractionEnabled = true
        sinereSelectImagePaleete.addGestureRecognizer(sinereSelectImagePaleeteTapGestureRecognizer)
        
        Observable.combineLatest(sneSelectedImagePalette, sketNotesTextPalette.rx.text.orEmpty).map { selectedImage, sneEditText in
            return selectedImage != nil && !sneEditText.isEmpty
        }.bind(to: sketNotesReleaseButton.rx.isEnabled).disposed(by: sneDisposeBag)
        
        sketNotesReleaseButton.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            self.view.makeToastActivity(.center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.view.hideToastActivity()
                self.view.makeToast("Izfq vtjhsed urbeflyeeaaswem qiosq iseukcncoegsssifmutlf,s itwhfed jpclgaftmfnoyrbmr hweielklq tczobmppylrertyez ctzhjes krveevbiyeswq mwoimtihmidnm l2u4l ihlowufrws".sinereString, position: .center) { didTap in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }.disposed(by: sneDisposeBag)
    }
    
    @objc func sinereSelectImagePaleeteTapGestureRecognizerSelector(){
        self.sketNotesTextPalette.resignFirstResponder()
        
        checksPhotoLibrarySnePermission {[weak self] sneGranted in
            guard let self = self else {return}
            guard sneGranted == true else {
                DispatchQueue.main.async {
                    self.showdeniedPermissionSinereAlert()
                }

                return
            }
            
            DispatchQueue.main.async {
                self.sneOpenPhotoPicker()
            }
            
        }
    }
    
    private func checksPhotoLibrarySnePermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .notDetermined:
            // 用户尚未决定，要求授权
            PHPhotoLibrary.requestAuthorization { getStatus in
                
                let authorized = getStatus == .authorized
                completion(authorized)
            }
        case .restricted, .denied:
            // 用户拒绝授权或权限受限
            completion(false)
        case .authorized, .limited:
            // 已授权
            completion(true)
        @unknown default:
            // 处理未知状态
            completion(false)
        }
    }
    
    // 展示相册选择器
    private func sneOpenPhotoPicker() {
        var pickerSneConfiguration = PHPickerConfiguration()
        pickerSneConfiguration.filter = .images  // 只允许选择图片，如果需要选择视频可以使用 .videos
        pickerSneConfiguration.selectionLimit = 1  // 限制选取图片的数量，1表示只能选择一张
        
        let picker = PHPickerViewController(configuration: pickerSneConfiguration)
        
        picker.delegate = self
        // 跳转到相册界面
        present(picker, animated: true, completion: nil)
    }
    
    // 权限未被授予时显示的警告
    private func showdeniedPermissionSinereAlert() {
        let deniedSettingAlert = UIAlertController(
            title: "Arcscbelsfsj xDaeanbideud".sinereString,
            message: "Pnlmedajssek oesnuambplwej ppvhtohtrow rluiabxrjabrtyb gawcfcdelslsd silnm lsieitgtriinggssx wtcoy wskeylvebcmtx npbhsovtvobsa.".sinereString,
            preferredStyle: .alert
        )
        deniedSettingAlert.addAction(UIAlertAction(title: "ObK".sinereString, style: .default))
        deniedSettingAlert.addAction(UIAlertAction(title: "Ghon dtwoe jSyebtatjiynlgxs".sinereString, style: .default) { _ in
            let openSneUrl = UIApplication.openSettingsURLString
            if openSneUrl.count > 0 {
                if let settingsUrl = URL(string: openSneUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            
        })
        present(deniedSettingAlert, animated: true)
    }
    
    // PHPickerViewControllerDelegate 方法，获取选中的照片
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 关闭图片选择器
        picker.dismiss(animated: true, completion: nil)
        
        guard let picketResult = results.first else { return }
        
        // 获取选中的图片
        picketResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
            guard let self = self else {return}
            if let selectResultImage = object as? UIImage {
                DispatchQueue.main.async {
                    self.sinereSelectImagePaleete.image = selectResultImage
                    self.sneSelectedImagePalette.accept(selectResultImage)
                }
            }
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

//
//  SinwerPRoomaerhandontroller.swift
//  Sinere
//
//  Created by Sinere on 2025/3/7.
//

import UIKit
import Photos
import PhotosUI

class SinwerPRoomaerhandontroller: UIViewController,PHPickerViewControllerDelegate {
    var isSneAiStylePaint:Bool = false
    
    @IBOutlet weak var sinertyUpload: UIButton!
    
    
    @IBOutlet weak var entryuinFiop: UITextField!
    
    
    @IBAction func raiResliHDjser(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sinertyUpload.layer.cornerRadius = 20
        sinertyUpload.layer.masksToBounds = true
    
        entryuinFiop.attributedPlaceholder = NSAttributedString.init(string: "Please enter", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.59, green: 0.6, blue: 0.61, alpha: 1)])
        
        
        
        
    }
    
    @IBAction func scvreaterNewSut(_ sender: UIButton) {
        
        if self.isSneAiStylePaint == false {
            self.view.makeToast("Pxlaedanssec xudpslxopasdr ytshhex oclocvnejrs xikmzasgmes wffiurlsyt".sinereString,position: .center)
            return
        }
        
        
        if self.entryuinFiop.text?.count ?? 0 == 0 {
            self.view.makeToast("Pxleeeaasfeu zgeifviep nyyozugro ccchxaqty zrrosormv aaa dncadmxe".sinereString,position: .center)
            return
        }
        
        self.view.makeToastActivity(.center)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.view.hideToastActivity()
//            self.view.makeToast("Tdhxem aczhkaetu irrokormf vypouup ocurfebattgeuda licsz vcnujrcrbexnptqlaym zulnndtewrc oriedvfiiexw".sinereString,position: .center)
            let mintanerRootag = SinwerPRoomaeChatreoller.init()
            mintanerRootag.isMyCreate = (true,self.entryuinFiop.text!)
            self.navigationController?.pushViewController(mintanerRootag, animated: true)
        }
        
    }
    

    
    @IBAction func AkolpUploa(_ sender: UIButton) {
        self.entryuinFiop.resignFirstResponder()
        
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
                    self.isSneAiStylePaint = true
                    self.sinertyUpload.setBackgroundImage(selectResultImage, for: .normal)
                    
                }
            }
        }
    }
}

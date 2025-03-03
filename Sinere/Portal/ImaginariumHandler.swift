//
//  ImaginariumHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import Alamofire
import PhotosUI

class ImaginariumHandler: CreativeBaseHandler,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PHPickerViewControllerDelegate {
    
    var isSneAiStylePaint = false

    @IBOutlet weak var imaginariumCollectionPalette: UICollectionView!
    
    var sneInputText:String?
    
    var smeResultImageAddress:String?
    
    var sneSectionArrayTwo:[String]!
    var sneSectionArrayThree:[String]!
    var sneSectionArrayFour:[String]!
    
    var sneSectionTwoIndex:IndexPath?
    var sneSectionThreeIndex:IndexPath?
    var sneSectionFourIndex:IndexPath?
    
    var userSneSelectedImage:UIImage?
    
    var changedSneImage:UIImage?
    
    @IBOutlet weak var sneGenerateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.init(red: 4/255.0, green: 6/255.0, blue: 32/255.0, alpha: 1)
        self.imaginariumCollectionPalette.register(UINib(nibName: "ImaginariumHandlerCollectionReusablePalette", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ImaginariumHandlerCollectionReusablePalette")
        
        self.imaginariumCollectionPalette.register(UINib(nibName: "ImaginariumOptimizationReusablePalette", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ImaginariumOptimizationReusablePalette")
        
        self.imaginariumCollectionPalette.register(ImaginariumCollectionTitleReusablePalette.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ImaginariumCollectionTitleReusablePalette")
        
        if isSneAiStylePaint {
            sneSectionArrayTwo = ["Idmlpqrbezsbstioojndilsem".sinereString,"Cyuwbjinsfm".sinereString,"Ssuirirsehanllizscm".sinereString,"Fgaguuvfiwsqm".sinereString,"Pzoiiknrtvimltlfimslm".sinereString]
            sneSectionArrayThree = ["Seuhbajdejcgt".sinereString,"Cdojlvour".sinereString,"Bjakcnkagtrnowuznbd".sinereString]
        }else{
            sneSectionArrayTwo = ["Ednxhzarnccoer qcjoxlooerjs".sinereString,"Mduwtceodu ztzoxnzeas".sinereString,"Mzornwobcthbrioomde".sinereString]
            sneSectionArrayThree = ["Sshtajrfpiesnn pdseltjajidlys".sinereString,"Brlnuvry jbjaccwkdgmrroqudnxd".sinereString,"Audkdl otiejxatpulrae".sinereString]
            sneSectionArrayFour = ["Onibln spnaoipnxtiicndg".sinereString,"Sakteqtqcmh".sinereString,"Ckajrutporoen".sinereString,"Viianqthaogne".sinereString,"Wxattgeirhcfowlaokr".sinereString,"Ptrniqnjt".sinereString]
        }
        
        let imaginariumCollectionPaletteLayout = SinereStyleAiLayoutFlow()
        
        imaginariumCollectionPaletteLayout.itemSize = UICollectionViewFlowLayout.automaticSize;
        imaginariumCollectionPaletteLayout.estimatedItemSize = CGSizeMake(134, 46);
        imaginariumCollectionPaletteLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 20, right: 12)
        imaginariumCollectionPaletteLayout.scrollDirection = .vertical;
        imaginariumCollectionPaletteLayout.minimumLineSpacing = 12;
        imaginariumCollectionPaletteLayout.minimumInteritemSpacing = 12;
        imaginariumCollectionPalette.setCollectionViewLayout(imaginariumCollectionPaletteLayout, animated: true)
        
        sneGenerateButton.rx.tap.subscribe { [weak self] _ in
            if let self = self {
                let withIdentifier = self.isSneAiStylePaint ? "ImaginariumResultHandler" : "ImaginariumOptimizationHandler"
                if self.isSneAiStylePaint == true {
                    if self.sneInputText?.count ?? 0 == 0 {
                        self.view.makeToast("Pcloeqaisjej hepndtseerr wtlhber ikvewyzwgohrzdksp xyxowud ywmainot".sinereString,position: .center)
                        return
                    }
                    
                    if self.sneSectionTwoIndex == nil {
                        self.view.makeToast("Pplcezabspew bsrepldeqcxtc oas mpgadiqnstfiknjgz asrtyymlee".sinereString,position: .center)
                        return
                    }
                    self.sneGenerateWantImage(identifier: withIdentifier)
                }else{
                    
                    if let sneInfo = SneTools.shareInfo.sneCurrentUser.value {
                        if sneInfo.diamondCount > 600 {
                            if self.sneSectionThreeIndex != nil ,let selectedImage = self.userSneSelectedImage{
                                
                                if self.sneSectionThreeIndex?.row == 0{
                                    self.changedSneImage = self.sharpenImage(image: selectedImage, sharpness: 2)
                                }else if self.sneSectionThreeIndex?.row == 1{
                                    self.changedSneImage = self.blurBackground(of: selectedImage, withRadius: 100)
                                }else if self.sneSectionThreeIndex?.row == 2{
                                    self.changedSneImage = self.blurBackground(of: selectedImage, withRadius: 500)
                                }
                                
                                if let _ = self.changedSneImage {
                                    self.view.makeToastActivity(.center)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.view.hideToastActivity()
                                        self.performSegue(withIdentifier: withIdentifier, sender: self)
                                    }
                                }else{
                                    self.view.makeToast("Olpkexrjaetkibosnn kfkawihlfefd".sinereString,position: .center)
                                }
                                
                                
                            }else{
                                if self.userSneSelectedImage == nil {
                                    self.view.makeToast("Polremanstez esxecljekcntw raj jpbiscztquarnej dfeiirjsvt".sinereString,position: .center)
                                }else{
                                    self.view.makeToast("Piljelatsjed rsdeglmescutv zcfljaurhiktvyy faqnwdj gddeptmadizl".sinereString,position: .center)
                                }
                            }
                        }else{
                            self.performSegue(withIdentifier: "DiamondHandler", sender: self)
                        }
                    }
                }
            }
        }.disposed(by: sneDisposeBag)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sneIdentifier = segue.identifier
        if sneIdentifier == "ImaginariumResultHandler"{
            if let imaginariumResultHandler = segue.destination as? ImaginariumResultHandler {
                imaginariumResultHandler.sneInputText = self.sneInputText!
                imaginariumResultHandler.smeResultImageAddress = self.smeResultImageAddress
            }
            return
        }
        
        if sneIdentifier == "ImaginariumOptimizationHandler"{
            if let imaginariumOptimizationHandler = segue.destination as? ImaginariumOptimizationHandler {
                imaginariumOptimizationHandler.changedImage = self.changedSneImage
            }
            return
        }
    }
    
    fileprivate func sneGenerateWantImage(identifier:String){
        if var sneInfo = SneTools.shareInfo.sneCurrentUser.value {
            if sneInfo.diamondCount > 600 {
                
                sneInfo.diamondCount = sneInfo.diamondCount - 600
                SneTools.shareInfo.sneCurrentUser.accept(sneInfo)
                
                self.view.makeToastActivity(.center)
                let threeString = self.sneSectionThreeIndex != nil ? "," + "Pzakisndtyiynmgs pfnoxcbuws".sinereString + ":" + self.sneSectionArrayThree[self.sneSectionThreeIndex!.row] + "." : "."
                let wantSneWords = "The current scene is the painting generation," + "My needs are " + self.sneInputText! + ", " + "Pxaviknotqijnqgu gsutbyqlme".sinereString + ":" + self.sneSectionArrayTwo[self.sneSectionTwoIndex!.row] + threeString
                let sneGenerateUrl = "hjtytypz:u/b/ownwbwu.lyvulaljnhgsbbnst.bxkydze/ktcahllkt/wadibDhreakw".sinereString
                AF.request(sneGenerateUrl,method: .post,parameters: ["edqeNko".sinereString:"1t1c1".sinereString,"pyrhozmnprtbs".sinereString:wantSneWords],encoding: JSONEncoding.default,headers: HTTPHeaders(["kheay".sinereString:"iwimhzh".sinereString])).validate().response { response in
                    self.view.hideToastActivity()
                    switch response.result {
                    case .success(let data):
                        if let sneResult = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                            if let sneResultDictionary = sneResult as? [String:Any] {
                                if let code = sneResultDictionary["code"] as? Int ,code == 200000{
                                    if let sneResultData = sneResultDictionary["data"] as? String {
                                        self.smeResultImageAddress = sneResultData  
                                        self.performSegue(withIdentifier: identifier, sender: self)
                                    }
                                 }
                            }
                        }
                    break
                    case .failure(_): break
                        
                    }
                }
            }else{
                self.performSegue(withIdentifier: "DiamondHandler", sender: self)
            }
        }
    }
    
    func blurBackground(of image: UIImage, withRadius blurRadius: Double) -> UIImage? {
        guard let inputImage = CIImage(image: image) else { return nil }
        
        let context = CIContext(options: nil)

        // 创建模糊滤镜
        guard let blurFilter = CIFilter(name: "CIGaussianBlur") else { return nil }
        blurFilter.setValue(inputImage, forKey: kCIInputImageKey)
        blurFilter.setValue(blurRadius, forKey: kCIInputRadiusKey)

        guard let blurredImage = blurFilter.outputImage else { return nil }

        // 创建遮罩（假设通过亮度区分背景与前景，具体可根据需要调整）
        guard let maskFilter = CIFilter(name: "CIColorControls") else { return nil }
        maskFilter.setValue(inputImage, forKey: kCIInputImageKey)
        maskFilter.setValue(0.0, forKey: kCIInputSaturationKey) // 转为灰度图
        maskFilter.setValue(1.1, forKey: kCIInputContrastKey)   // 增强对比度

        guard let maskImage = maskFilter.outputImage else { return nil }

        // 将模糊后的背景和原图结合
        guard let blendFilter = CIFilter(name: "CIBlendWithMask") else { return nil }
        blendFilter.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
        blendFilter.setValue(blurredImage, forKey: kCIInputImageKey)
        blendFilter.setValue(maskImage, forKey: kCIInputMaskImageKey)

        // 生成最终图片
        guard let outputImage = blendFilter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
    
    
    
    func sharpenImage(image: UIImage, sharpness: Float = 1.0) -> UIImage? {
        guard let inputImage = CIImage(image: image) else { return nil }
        
        let context = CIContext()
        
        // 使用 CISharpenLuminance 滤镜锐化图像
        guard let filter = CIFilter(name: "CISharpenLuminance") else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(sharpness, forKey: "inputSharpness")  // 调整锐化强度，范围通常为 0 到 2
        
        // 获取输出图像
        guard let outputImage = filter.outputImage else { return nil }
        
        // 获取 CIContext 创建的 CGImage
        guard let cgImage = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }
        
        // 返回锐化后的图像
        return UIImage(cgImage: cgImage)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imaginariumCollectionPalette = collectionView.dequeueReusableCell(withReuseIdentifier: "ImaginariumCollectionPalette", for: indexPath) as! ImaginariumCollectionPalette
        if indexPath.section == 1 {
            
            imaginariumCollectionPalette.backgroundButton.isSelected = sneSectionTwoIndex == indexPath
            
            imaginariumCollectionPalette.imaginariumTitle.text = sneSectionArrayTwo[indexPath.row]
        }else if indexPath.section == 2 {
            imaginariumCollectionPalette.backgroundButton.isSelected = sneSectionThreeIndex == indexPath
            imaginariumCollectionPalette.imaginariumTitle.text = sneSectionArrayThree[indexPath.row]
        }else{
            imaginariumCollectionPalette.backgroundButton.isSelected = sneSectionFourIndex == indexPath
            imaginariumCollectionPalette.imaginariumTitle.text = sneSectionArrayFour[indexPath.row]
        }
        
        return imaginariumCollectionPalette
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if indexPath != sneSectionTwoIndex {
                sneSectionTwoIndex = indexPath
            }
        }else if indexPath.section == 2 {
            if indexPath != sneSectionThreeIndex {
                sneSectionThreeIndex = indexPath
            }
        }else{
            if indexPath != sneSectionFourIndex {
                sneSectionFourIndex = indexPath
            }
        }
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                if isSneAiStylePaint {
                    let imaginariumHandlerCollectionReusablePalette = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImaginariumHandlerCollectionReusablePalette", for: indexPath) as! ImaginariumHandlerCollectionReusablePalette
                    imaginariumHandlerCollectionReusablePalette.sneEnterTextPaletteinputChanged = { [weak self] newValue in
                        guard let self = self else {return}
                        self.sneInputText = newValue
                    }
                    imaginariumHandlerCollectionReusablePalette.sneEnterTextPalette.text = sneInputText
                    if self.sneInputText?.count ?? 0 > 0 {
                        imaginariumHandlerCollectionReusablePalette.sneEnterTextPalette.text = self.sneInputText
                    }
                    return imaginariumHandlerCollectionReusablePalette
                }else{
                    let imaginariumOptimizationReusablePalette = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImaginariumOptimizationReusablePalette", for: indexPath) as! ImaginariumOptimizationReusablePalette
                    imaginariumOptimizationReusablePalette.imaginariumNotesTapNoti = { [weak self] in
                        guard let self = self else {return}
                        self.checksPhotoLibrarySnePermission { sneGranted in
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
                    
                    imaginariumOptimizationReusablePalette.imaginariumNotes.isHidden = false
                    if self.userSneSelectedImage != nil {
                        imaginariumOptimizationReusablePalette.imaginariumImage.image = self.userSneSelectedImage!
                        imaginariumOptimizationReusablePalette.imaginariumNotes.isHidden = true
                    }
                    return imaginariumOptimizationReusablePalette
                }
            }else{
                
                if isSneAiStylePaint {
                    let imaginariumCollectionTitleReusablePalette = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImaginariumCollectionTitleReusablePalette", for: indexPath) as! ImaginariumCollectionTitleReusablePalette
                    imaginariumCollectionTitleReusablePalette.reusableTitle.text = indexPath.section == 1 ? "Pvadiunctdiendgc xsmtnyelae".sinereString : "Pmafilnmtmiuncgi efiohczuys".sinereString
                    imaginariumCollectionTitleReusablePalette.sneOptionalTitle.text = indexPath.section == 1 ? "" : "(\("Oxpvtwilolnsayl".sinereString))"
                    
                    return imaginariumCollectionTitleReusablePalette
                }else{
                    let imaginariumCollectionTitleReusablePalette = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImaginariumCollectionTitleReusablePalette", for: indexPath) as! ImaginariumCollectionTitleReusablePalette
            
                    if indexPath.section == 1 {
                        imaginariumCollectionTitleReusablePalette.reusableTitle.text = "Cootlookrb aaldxjfubshtomyetnnt".sinereString
                        imaginariumCollectionTitleReusablePalette.sneOptionalTitle.text = ""
                    }else if indexPath.section == 2 {
                        imaginariumCollectionTitleReusablePalette.reusableTitle.text = "Cnlbamrmijtcyb yaznkdk cDeeptkagiel".sinereString
                        imaginariumCollectionTitleReusablePalette.sneOptionalTitle.text = "(\("Muuklitsiypmlve".sinereString))"
                    }else{
                        imaginariumCollectionTitleReusablePalette.reusableTitle.text = "Apratn nFwidlntcekr".sinereString
                        imaginariumCollectionTitleReusablePalette.sneOptionalTitle.text = ""
                    }
                    
                    
                    return imaginariumCollectionTitleReusablePalette
                }
                
                
            }
        }
        return UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SneTools.sneWidthScreen, height: 205)
        }else {
            return CGSize(width: SneTools.sneWidthScreen, height: 67)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 + (isSneAiStylePaint ? 0 : 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return section
        }else if section == 1 {
            
            if isSneAiStylePaint {
                return 5
            }else{
                return 3
            }
        }else if section == 2{
            return 3
        }else{
            return 6
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
                    self.userSneSelectedImage = selectResultImage
                    UIView.performWithoutAnimation {
                        self.imaginariumCollectionPalette.reloadSections(IndexSet(integer: 0))
                    }
                }
            }
        }
    }
}


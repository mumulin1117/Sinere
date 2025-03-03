//
//  InstantRelayContactHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/22.
//

import UIKit
import AVFoundation

class InstantRelayContactHandler: CreativeBaseHandler {
    
    private var instantReplayCaptureSession: AVCaptureSession?
    private var instantReplyLocalPreviewLayer: AVCaptureVideoPreviewLayer?
    private var instantReplyTimer: Timer?
    private var instantReplayMaxTime: Int = 15
    private let instantReplayFirendImagePalette = UIImageView()
    private let instantReplayLoadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    var spaceUserObject:SneUserObject?
    
    let contactItemOpeartions = ["sinereContacttoggleCamer", "sinereContactmicohone", "sinereContactVideo", "sinereContactClose"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.13, alpha: 1)
        
        setupRemoteImageContactImage()
        setcontactItemOpeartions()
        setupSneActivitySneIndicator()
        sinerePermissionState()
        
        if let _spaceUserObject = self.spaceUserObject {
            instantReplayFirendImagePalette.image = UIImage(named: _spaceUserObject.profileThumbnail)
        }
        
        let itemClick = { [weak self] in
            guard let self = self else {return}
            self.presentActionSheet()
        }
        
        sinereRightButtonItems(imageNames: ["sinereDetailComplain"], buttonClicks: [itemClick])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        instantReplyTimer?.invalidate()
        instantReplyTimer = nil
        instantReplayCaptureSession?.stopRunning()
        instantReplayCaptureSession?.inputs.forEach { instantReplayCaptureSession?.removeInput($0) }
        instantReplayCaptureSession?.outputs.forEach { instantReplayCaptureSession?.removeOutput($0) }
        instantReplyLocalPreviewLayer?.removeFromSuperlayer()
        instantReplyLocalPreviewLayer = nil
        instantReplayCaptureSession = nil
    }
    
    private func startTimerWait(){
        instantReplyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerWaitRun), userInfo: nil, repeats: true)
        RunLoop.current.add(instantReplyTimer!, forMode: .common)
    }
    
    @objc private func timerWaitRun(){
        instantReplayMaxTime -= 1
        if instantReplayMaxTime < 0 {
            self.view.makeToast("Tkhsew yoftfhoerrl xpvaaritmyy fiqsf entostk bohnoluidnaer!".sinereString, position: .center)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.stopSneSession()
            }
        }
    }
    
    private func presentActionSheet() {
        
        let reportSneActionTitle = "Rxewpuomrpt".sinereString
        let actionSneTouchSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let reportSneAction = UIAlertAction(title: reportSneActionTitle, style: .default) {[weak self] _ in
            guard let self = self else {return}
            self.performSegue(withIdentifier: "SinereViolationReportPanelHandler", sender: self)
        }
        actionSneTouchSheet.addAction(reportSneAction)
        
        if reportSneActionTitle.count > 0 {
            let blockSneActionTitle = "Andrdn btzoe gbelbascxkyllihsrt".sinereString
            let blockSneAction = UIAlertAction(title: blockSneActionTitle, style: .default) {[weak self] _ in
                guard let self = self else {return}
                self.view.makeToastActivity(.center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.view.hideToastActivity()
                    SneTools.shareInfo.myShieldPortal.append(self.spaceUserObject!)
                    NotificationCenter.default.post(name: Notification.Name("getAllPortalDatas"), object: nil)
                    self.view.makeToast("Brllaacnkqlnilsoto xsiuccrcbeqszs".sinereString,position: .center) { didTap in
                        if let sneViewControllers = self.navigationController?.viewControllers {
                            for sneControllerItem in sneViewControllers {
                                if sneControllerItem is InstantRelayListHandler {
                                    self.instantReplyTimer?.invalidate()
                                    self.instantReplyTimer = nil
                                    self.instantReplayCaptureSession?.stopRunning()
                                    self.instantReplayCaptureSession?.inputs.forEach { self.instantReplayCaptureSession?.removeInput($0) }
                                    self.instantReplayCaptureSession?.outputs.forEach { self.instantReplayCaptureSession?.removeOutput($0) }
                                    self.instantReplyLocalPreviewLayer?.removeFromSuperlayer()
                                    self.instantReplyLocalPreviewLayer = nil
                                    self.instantReplayCaptureSession = nil
                                    
                                    self.navigationController?.popToViewController(sneControllerItem, animated: true)
                                    break
                                }
                                
                                if sneControllerItem is MySpaceHandler {
                                    
                                    self.instantReplyTimer?.invalidate()
                                    self.instantReplyTimer = nil
                                    self.instantReplayCaptureSession?.stopRunning()
                                    self.instantReplayCaptureSession?.inputs.forEach { self.instantReplayCaptureSession?.removeInput($0) }
                                    self.instantReplayCaptureSession?.outputs.forEach { self.instantReplayCaptureSession?.removeOutput($0) }
                                    self.instantReplyLocalPreviewLayer?.removeFromSuperlayer()
                                    self.instantReplyLocalPreviewLayer = nil
                                    self.instantReplayCaptureSession = nil
                                    
                                    self.navigationController?.popToViewController(sneControllerItem, animated: true)
                                    break
                                }
                            }
                        }
                    }
                }
            }
            actionSneTouchSheet.addAction(blockSneAction)
            
            if blockSneActionTitle.count > 0 {
                let cancelSneActionTitle = "Ckadnfcteyl".sinereString
                let cancelSneAction = UIAlertAction(title: cancelSneActionTitle, style: .cancel)
                actionSneTouchSheet.addAction(cancelSneAction)
                
                if cancelSneActionTitle.count > 0 {
                    self.present(actionSneTouchSheet, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setupRemoteImageContactImage() {
        instantReplayFirendImagePalette.contentMode = .scaleAspectFill
        instantReplayFirendImagePalette.layer.masksToBounds = true
        view.addSubview(instantReplayFirendImagePalette)
        instantReplayFirendImagePalette.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instantReplayFirendImagePalette.topAnchor.constraint(equalTo: view.topAnchor),
            instantReplayFirendImagePalette.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            instantReplayFirendImagePalette.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            instantReplayFirendImagePalette.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSneActivitySneIndicator() {
        instantReplayLoadingIndicator.center = view.center
        view.addSubview(instantReplayLoadingIndicator)
        instantReplayLoadingIndicator.startAnimating()
    }
    
    private func setcontactItemOpeartions() {
        
        for (index, item) in contactItemOpeartions.enumerated() {
            let instantReplayTempButton = UIButton(type: .custom)
            instantReplayTempButton.tag = 100 + index
            instantReplayTempButton.setBackgroundImage(UIImage(named: item), for: .normal)
            if index == 1 || index == 2 {
                instantReplayTempButton.setBackgroundImage(UIImage(named: "\(item)Close"), for: .selected)
            }
            instantReplayTempButton.addTarget(self, action: #selector(itemButtonSne(_:)), for: .touchUpInside)
            view.addSubview(instantReplayTempButton)
            instantReplayTempButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                instantReplayTempButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34 + SneTools.sneRatio + CGFloat(index) * (84 * SneTools.sneRatio)),
                instantReplayTempButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(37 * SneTools.sneRatio + 20)),
                instantReplayTempButton.widthAnchor.constraint(equalToConstant: 60 * SneTools.sneRatio),
                instantReplayTempButton.heightAnchor.constraint(equalToConstant: 60 * SneTools.sneRatio)
            ])
        }
    }
    
    @objc private func itemButtonSne(_ sender: UIButton) {
        let clickIndex = sender.tag - 100
        switch clickIndex {
        case 0:
            toggleSneCamera()
        case 1:
            sender.isSelected.toggle()
            stopSneMicrophone(isStop: sender.isSelected)
        case 2:
            sender.isSelected.toggle()
            stopSneCameraPreview(isStop: sender.isSelected)
        case 3:
            stopSneSession()
        default:
            break
        }
    }
    
    private func toggleSneCamera() {
        guard let session = instantReplayCaptureSession else { return }
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        let currentPosition = currentInput.device.position
        session.removeInput(currentInput)
        
        let newPosition: AVCaptureDevice.Position = (currentPosition == .back) ? .front : .back
        guard let newDevice = camera(with: newPosition),
              let newInput = try? AVCaptureDeviceInput(device: newDevice) else { return }
        
        if session.canAddInput(newInput) {
            session.addInput(newInput)
        }
    }
    
    private func camera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position).devices.first
    }
    
    private func stopSneCameraPreview(isStop: Bool) {
        if isStop {
            instantReplayCaptureSession?.inputs.forEach { instantReplayCaptureSession?.removeInput($0) }
            instantReplyLocalPreviewLayer?.isHidden = true
        } else {
            guard let session = instantReplayCaptureSession,
                  let device = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: device) else { return }
            if session.canAddInput(input) {
                session.addInput(input)
            }
            instantReplyLocalPreviewLayer?.isHidden = false
        }
    }
    
    private func stopSneMicrophone(isStop: Bool) {
        guard let session = instantReplayCaptureSession else { return }
        if isStop {
            session.inputs
                .compactMap { $0 as? AVCaptureDeviceInput }
                .filter { $0.device.hasMediaType(.audio) }
                .forEach { session.removeInput($0) }
        } else {
            guard let device = AVCaptureDevice.default(for: .audio),
                  let input = try? AVCaptureDeviceInput(device: device) else { return }
            if session.canAddInput(input) {
                session.addInput(input)
            }
        }
    }
    
    private func stopSneSession() {
        instantReplyTimer?.invalidate()
        instantReplyTimer = nil
        instantReplayCaptureSession?.stopRunning()
        instantReplayCaptureSession?.inputs.forEach { instantReplayCaptureSession?.removeInput($0) }
        instantReplayCaptureSession?.outputs.forEach { instantReplayCaptureSession?.removeOutput($0) }
        instantReplyLocalPreviewLayer?.removeFromSuperlayer()
        instantReplyLocalPreviewLayer = nil
        instantReplayCaptureSession = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sinerePermissionState() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { self?.selectSneCaptureSession() }
                }
            }
        case .authorized:
            selectSneCaptureSession()
        default:
            break
        }
    }
    
    private func selectSneCaptureSession() {
        guard instantReplayCaptureSession == nil else { return }
        instantReplayCaptureSession = AVCaptureSession()
        instantReplayCaptureSession?.sessionPreset = .high
        
        guard let frontCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first,
              let input = try? AVCaptureDeviceInput(device: frontCamera),
              instantReplayCaptureSession?.canAddInput(input) == true else { return }
        
        instantReplayCaptureSession?.addInput(input)
        setupSnePreviewLayer()
    }
    
    private func setupSnePreviewLayer() {
        guard instantReplyLocalPreviewLayer == nil else { return }
        instantReplyLocalPreviewLayer = AVCaptureVideoPreviewLayer(session: instantReplayCaptureSession!)
        instantReplyLocalPreviewLayer?.videoGravity = .resizeAspectFill
        instantReplyLocalPreviewLayer?.cornerRadius = 16
        instantReplyLocalPreviewLayer?.masksToBounds = true
        instantReplyLocalPreviewLayer?.frame = CGRect(x: UIScreen.main.bounds.width - 153,
                                         y: UIScreen.main.bounds.height - 341,
                                         width: 129,
                                         height: 204)
        if let preview = instantReplyLocalPreviewLayer {
            view.layer.addSublayer(preview)
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.instantReplayCaptureSession?.startRunning()
        }
        
        startTimerWait()
    }
}

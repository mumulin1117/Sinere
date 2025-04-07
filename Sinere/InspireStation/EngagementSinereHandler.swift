//
//  EngagementSinereHandler.swift
//  Sinere
//
//  Created by Sinere on 2024/11/27.
//

import UIKit
import WebKit

class EngagementSinereHandler: CreativeBaseHandler,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {

    var engagementPalette:WKWebView!
    
    var engagementAgreement:String?
    
    var engagementPaletteFull = false
    
    var engagementHandler: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if ((engagementAgreement?.contains("?taepyptIedq=".sinereString)) != nil) && ((engagementAgreement?.contains("&ytfohkaejnr=".sinereString)) != nil){
            engagementPaletteFull = true
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            let backSneground = UIImageView(image: UIImage(named: "SinereLaunchScreen"))
            backSneground.contentMode = .scaleAspectFill
            self.view.addSubview(backSneground)
            backSneground.snp.makeConstraints { make in
                make.left.top.equalToSuperview()
                make.right.bottom.equalToSuperview()
            }
            
            SneTools.shareInfo.chronicleSpectrum()
        }
        
        self.view.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.13, alpha: 1)
        let engagementConfig = WKWebViewConfiguration()
        engagementConfig.allowsInlineMediaPlayback = true
        engagementConfig.allowsAirPlayForMediaPlayback = false
        engagementConfig.mediaTypesRequiringUserActionForPlayback = []
        engagementConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.engagementSinere(engagementConfig: engagementConfig)
        
        
        engagementHandler = { [weak self] engagement in
            guard let self = self else {return}
            let SneControl = engagementPalette.configuration.userContentController
            if engagement == 0 {
                SneControl.add(self, name: "Pnady".sinereString)
                SneControl.add(self, name: "Cgldousje".sinereString)
            }else{
                SneControl.removeScriptMessageHandler(forName: "Pnady".sinereString)
                SneControl.removeScriptMessageHandler(forName: "Cgldousje".sinereString)
            }
        }
        
        self.view.makeToastActivity(.center)
        if let _engagementAgreement = engagementAgreement ,let engagementUrl = URL(string: _engagementAgreement){
            engagementPalette.load(URLRequest(url: engagementUrl))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        engagementHandler?(0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        engagementHandler?(1)
    }
    
    func engagementSinere(engagementConfig:WKWebViewConfiguration){
        engagementPalette = WKWebView(frame: .zero, configuration: engagementConfig)
        engagementPalette.scrollView.alwaysBounceVertical = false
        engagementPalette.scrollView.contentInsetAdjustmentBehavior = .never
        engagementPalette.allowsBackForwardNavigationGestures = true
        engagementPalette.isHidden = true
        engagementPalette.uiDelegate = self
        engagementPalette.navigationDelegate = self
        
        self.view.addSubview(engagementPalette)
        engagementPalette.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(engagementPaletteFull ? 0 : SneTools.navigationSneFullHeight)
            make.right.equalToSuperview()
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            
            let sneName = message.name
            let sneBody = message.body
            if sneName.count > 0 {
                if sneName == "Pnady".sinereString , let sneBodyString = sneBody as? String {
                    AcquisitionOrchestrator.shared.acquisitionOrchestratorCpmpletion = { sneCallBackResult in
                        
                        DispatchQueue.main.async {
                            if let sneReaulError = sneCallBackResult.0{
                                self.view.hideToastActivity()
                                self.view.makeToast(sneReaulError.localizedDescription,position: .center)
                            }else{
                                if let orbitMarker = sneCallBackResult.1,let starlightToken = sneCallBackResult.2 {
                                    SneTools.shareInfo.verifyCelestialPath(orbitMarker: orbitMarker, starlightToken: starlightToken,celestial: sneBodyString,baseView: self.view)
                                }
                            }
                        }
                    }
                    
                    self.view.makeToastActivity(.center)
//                    SneTools.shareInfo.initAppeventLog(logType: sneBodyString)
                    AcquisitionOrchestrator.shared.suggestInspirationBasedOnArtistPreferenceAndCurrentTrends(sneBodyString)
                    
                    return
                }
                
                if message.name == "Cgldousje".sinereString{
                    UserDefaults.standard.removeObject(forKey: "sneUserTokenInfo")
                    UserDefaults.standard.synchronize()
                    SneTools.shareInfo.sneUserTokenInfo = ""
                    NotificationCenter.default.post(name: NSNotification.Name("NotificationCenterName"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
        }
    }
    
    deinit {
        engagementPalette.configuration.userContentController.removeScriptMessageHandler(forName: "Pnady".sinereString)
        engagementPalette.configuration.userContentController.removeScriptMessageHandler(forName: "Cgldousje".sinereString)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let navigationActionTargetFrame = navigationAction.targetFrame == nil
        var windowFeaturesTag = 188
        if navigationActionTargetFrame || navigationAction.targetFrame?.isMainFrame == false {
            windowFeaturesTag = 188 * 10
            if windowFeaturesTag == 1880 {
                if let navigationActionRequestUrl = navigationAction.request.url{
                    UIApplication.shared.open(navigationActionRequestUrl)
                }
            }
        }
        
        return nil
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.hideToastActivity()
        webView.isHidden = false
    }

}

//
//  AppDelegate.swift
//  Sinere
//
//  Created by Sinere on 2024/11/20.
//

import UIKit
//import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getSnePushPermission()
        _ = AcquisitionOrchestrator.shared
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenChars = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let sneDevicePush = tokenChars.joined()
        if sneDevicePush.count > 0 {
            SneTools.shareInfo.sneDeviceTPush = sneDevicePush
        }
    }
    
    
    func getSnePushPermission() {
        let nitificationCenter = UNUserNotificationCenter.current()
        
        nitificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                return
            }
            
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    
                }
            }
        }
    }

}


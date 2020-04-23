//
//  AppDelegate.swift
//  Supplement Superstores
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupNavigationAppearance()
        return true
        
    }
    
     class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//    func checkUserSession() {
//            
//        let user = LoginUtils.sharedInstance.getUserToDefaults()
//            if user != nil {
//                
//           
//            setHomeAsRVC()
//                
//    } else {
//        setGuestAsRVC()
//                
//        }
//    }
    
    
    func setHomeAsRVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "entryPointNVC")as? UINavigationController
        window?.rootViewController = vc
    }
    
    func setupNavigationAppearance() {
        let navigationbarAppearance = UINavigationBar.appearance()
       // navigationbarAppearance.barStyle = .default
        navigationbarAppearance.tintColor = UIColor.white
        navigationbarAppearance.barTintColor = UIColor.init(red: 22/255.0, green: 125/255.0, blue: 210/255.0, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationbarAppearance.titleTextAttributes = textAttributes
       // navigationbarAppearance.shadowImage = nil
       // navigationbarAppearance.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Javacom", size: 17.0)!]
    }

}


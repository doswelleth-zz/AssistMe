//
//  AppDelegate.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = FocusTableViewController()
        let navigation = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}


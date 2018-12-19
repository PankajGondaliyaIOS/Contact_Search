//
//  AppDelegate.swift
//  CodeTest_Pankaj_Gondaliya
//
//  Created by newuser on 2018-12-17.
//  Copyright © 2018 PankajGondaliya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigation()
        return true
    }
    
    //MARK: Navitaion
    func configureNavigation() {
        UINavigationBar.appearance().barTintColor = UIColor.themeColor(alpha: 1.0)
        let navbarFont = UIFont(name: "HelveticaNeue-Medium", size: 18)!
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: navbarFont, NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    

}


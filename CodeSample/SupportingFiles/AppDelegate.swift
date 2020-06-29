//
//  AppDelegate.swift
//  CodeSample
//
//  Created by adauto.pinheiro on 26/06/20.
//  Copyright © 2020 Adauto Pinheiro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UIViewController()
        return true
    }
}

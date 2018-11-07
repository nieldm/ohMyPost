//
//  AppDelegate.swift
//  ohMyPost
//
//  Created by Daniel Mendez on 11/4/18.
//  Copyright © 2018 nieldm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createContainer { (container) in
            let vc = PostsViewController(managedObjectContext: container.viewContext)
            let nav = UINavigationController(rootViewController: vc).then {
                $0.navigationBar.tintColor = .turquoiseBlue
            }
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}


}


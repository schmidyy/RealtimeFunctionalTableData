//
//  AppDelegate.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      Theme.apply()

      let serviceProvider = ServiceProvider(configuration: .firebase)
      let listViewController = ListViewController(serviceProvider: serviceProvider)

      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = UINavigationController(rootViewController: listViewController)
      window?.makeKeyAndVisible()

      return true
    }
}

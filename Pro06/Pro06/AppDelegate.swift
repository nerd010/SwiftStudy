//
//  AppDelegate.swift
//  Pro06
//
//  Created by richard on 28/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let splitViewController = window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    splitViewController.delegate = self
    
    
    return true
  }
}


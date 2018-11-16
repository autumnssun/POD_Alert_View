//
//  AppDelegate.swift
//  NN_Alert_Demo
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import UIKit
import IQKeyboardManager
import NN_Alert
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NN_Alert_Manager.shared.style = NN_Styles(colorSets: NN_Styles.NN_Alerts_Colors(textLight: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), textDark: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),firstColor:#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)),fontSets:NN_Styles.NN_Alerts_Fonts(titleFont: UIFont(name: "SnellRoundhand-Bold", size: UIFont.labelFontSize), detailFont: UIFont(name: "ChalkboardSE-Regular", size: UIFont.systemFontSize)))
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


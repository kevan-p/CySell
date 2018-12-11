//
//  AppDelegate.swift
//  Frontend
//
//  Created by Mitchell Knoth on 9/18/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import JSQMessagesViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //notification.post(.init(name: is_Background))
        SavedArr = SavedArr + MessageArr_test
        save(SavedArr)
        print("saving array in Arr")
        print(SavedArr)
        //defaults.set(seller_id, forKey: "seller_id")
        //defaults.set(seller_name, forKey: "seller_name")
    }
    
    func save(_ MessageArr_test : [message_t]){
        //Arr = Arr + MessageArr_test
        let data = MessageArr_test.map { try? JSONEncoder().encode($0) }
        defaults.set(data, forKey: "history")
        defaults.synchronize()
    }

    func applicationDidBecomeActive(_ application: UIApplication){
    
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}


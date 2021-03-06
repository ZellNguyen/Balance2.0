//
//  AppDelegate.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-10.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = UIColor.black
        pageController.backgroundColor = UIColor.white
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        navigationBar.tintColor = UIColor.darkGray
        //navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Seravek-Medium", size: 18)! ]
        
        //navigationBar.isTranslucent = false
        
        
        // UITabBar
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        // Segmented Controller
        //let attr = NSDictionary(object: UIFont(name: "Seravek", size: 16.0)!, forKey: NSFontAttributeName as NSCopying)
        //UISegmentedControl.appearance().setTitleTextAttributes(attr as! [AnyHashable : Any], for: .normal)
        
        IQKeyboardManager.sharedManager().enable = true
        
        
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
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    func countStep() {
        StepCounter.main.authorizeHealthKit(completion: { (success, error) -> Void in
            if success {
                print("HealthKit authorization succeeded")
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                StepCounter.main.recentSteps(yesterday!, completion: { (steps, error) -> Void in
                    StepCounter.main.steps = StepCounter.main.steps + Int(steps)
                    print(StepCounter.main.steps)
                    if error != nil {
                        print("CANNOT AUTHORIZE")
                    }
                })
            }
            else {
                if error != nil {
                    print("CANNOT AUTHORIZE")
                }
            }
        })
    }
}


//
//  AppDelegate.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
//import iOSPlayerSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate{
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = MasterViewController()
       window?.rootViewController = UINavigationController(rootViewController: WorkshopsInteractiveViewController())
        window?.makeKeyAndVisible()
        
//        USUstreamPlayer.configure(withApiKey: "0J4Nofz3V0KOegRgjYsQJcxlkCYeERgu9EUX1cgP")
        Messaging.messaging().delegate = self
        Messaging.messaging().subscribe(toTopic: "Conapeme-general")
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        
        
        // Override point for customization after application launch.
        return true
    }
    
    
    
}

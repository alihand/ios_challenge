//
//  AppDelegate.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 21.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UtilitiesHelper.clearImageCache()
        UtilitiesHelper.configImageCache()
                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white;
        
        let movieListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListVC")
        let navigationController = UINavigationController(rootViewController: movieListController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


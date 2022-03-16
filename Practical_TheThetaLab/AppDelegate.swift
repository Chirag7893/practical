//
//  AppDelegate.swift
//  Practical_TheThetaLab
//
//  Created by Chirag Patel on 16/03/22.
//

import UIKit
import Reachability

let kUserDetails = "UserDetails"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow!
    var reachable: Reachability!
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    var loginUserData: [String:Any]?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try reachable = Reachability.init()
        }
        catch {
            print("error in init Reachability")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged, object: reachable)
        do {
            try reachable.startNotifier()
        }
        catch {
            print("could not start reachability notifier")
        }
        
        if let data = UserDefaults.standard.object(forKey: kUserDetails) as? [String:Any], !data.isEmpty {
            self.navigateToHomeScreen()
        }
        else{
            self.navigateToLoginScreen()
        }
        
        return true
    }
    
    //MARK: - Reachability Method
    @objc func reachabilityChanged(note: NSNotification) {
        let reachable = note.object as! Reachability
        
        if reachable.connection != .unavailable {
            if reachable.connection != .wifi {
                print("Reachable via WiFi")
            }
            else {
                print("Reachable via Cellular")
            }
        }
        else {
            let alert: UIAlertController = UIAlertController.init(title: "No Internet", message: "Sorry, no Internet connectivity detected. Please reconnect and try again", preferredStyle: .alert)
            let hideAstion: UIAlertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(hideAstion)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func navigateToHomeScreen() {
        let viewController = self.storyBoard.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.barStyle = .black
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        appDelegate.window?.rootViewController = navigationController
    }
    
    func navigateToLoginScreen() {
        let viewController = self.storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.barStyle = .black
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        appDelegate.window?.rootViewController = navigationController
    }
    
    func saveUserDetails(userDetails: [String:Any]) {
        appDelegate.loginUserData = userDetails
        UserDefaults.standard.set(userDetails, forKey: kUserDetails)
        UserDefaults.standard.synchronize()
    }
    
    func clearAllUserDataFromPreference() {
        appDelegate.loginUserData = nil
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}


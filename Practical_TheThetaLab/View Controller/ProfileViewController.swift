//
//  ProfileViewController.swift
//  Practical_TheThetaLab
//
//  Created by Chirag Patel on 16/03/22.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogout: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.object(forKey: kUserDetails) as? [String:Any], !data.isEmpty {
            if let email = data["email"] as? String{
                self.lblEmail.text = email
            }
        }
    }
    
    @IBAction func btnLogout_clicked(_ sender: Any) {
        appDelegate.clearAllUserDataFromPreference()
        appDelegate.navigateToLoginScreen()
    }
}

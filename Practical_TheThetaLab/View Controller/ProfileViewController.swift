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
    
    @IBAction func btnLogout_clicked(_ sender: Any) {
        appDelegate.navigateToLoginScreen()
    }
}

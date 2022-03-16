//
//  ViewController.swift
//  Practical_TheThetaLab
//
//  Created by Chirag Patel on 16/03/22.
//

import UIKit
import Alamofire
import KRProgressHUD
import ObjectMapper
import Kingfisher
import Reachability
import ObjectMapper

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
}

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLogin_clicked(_ sender: Any) {
        appDelegate.navigateToHomeScreen()
//        if self.txtEmail.text?.count == 0 {
//            self.showSimpleAlert(message: "Please enter email address")
//        }
//        else if !self.txtEmail.text!.isValidEmail() {
//            self.showSimpleAlert(message: "Please enter valid email address")
//        }
//        else if self.txtPassword.text?.count == 0 {
//            self.showSimpleAlert(message: "Please enter password")
//        }
//        else{
//        }
    }
}

class BaseViewController: UIViewController {
    func showSimpleAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


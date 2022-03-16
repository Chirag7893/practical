//
//  HomeViewController.swift
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

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class UserListTblCellL: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAge: UILabel!
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var userList = [BaseResponseModel]()
    var searchUserList = [BaseResponseModel]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserList()
    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchUserList = self.userList.filter { $0.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased() }
        self.searching = true
        self.tblHome.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.tblHome.reloadData()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return self.searchUserList.count
        } else {
            return self.userList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTblCellL", for: indexPath) as! UserListTblCellL
        
        var objModel: BaseResponseModel?
        
        if searching {
            objModel = self.searchUserList[indexPath.row]
        } else {
            objModel = self.userList[indexPath.row]
        }
        
        if let name = objModel?.name {
            cell.lblName.text = "Name : \(name)"
        }
        
        if let email = objModel?.email {
            cell.lblEmail.text = "Email : \(email)"
        }
        
        if let age = objModel?.age {
            cell.lblAge.text = "Age : \(age)"
        }
        
        return cell
    }
    
}

extension HomeViewController {
    func getUserList() {
        if appDelegate.reachable.connection != .unavailable {
            KRProgressHUD.show()

            let apiURL = "http://139.162.53.200:3000/?child=false"

            print("API -> \(apiURL)")
            
            Alamofire.request(apiURL, method: .get, parameters: nil).validate().responseJSON { response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    KRProgressHUD.dismiss()
                }
                switch response.result {
                case .success:
                    let json = try! JSONSerialization.jsonObject(with: response.data!)
                    print("RESPONSE -> \(json)")
                    
                    let arraData = Mapper<BaseResponseModel>().mapArray(JSONObject: json)
                    
                    if let arraData = arraData {
                        self.userList = arraData
                    }
                    
                    self.tblHome.reloadData()
                    
                case .failure(let error):
                    print (error)
                }
            }
        }
        else {
            let alert: UIAlertController = UIAlertController.init(title: "No Internet", message: "Sorry, no Internet connectivity detected. Please reconnect and try again", preferredStyle: .alert)
            let hideAstion: UIAlertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(hideAstion)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

//
//  BaseResponseModel.swift
//  PracticalTest_One_Tech
//
//  Created by Chirag Patel on 12/03/22.
//

import Foundation
import ObjectMapper

struct BaseResponseModel : Mappable {
    var id : String?
    var parent : String?
    var level : Int?
    var name : String?
    var age : Int?
    var email : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        parent <- map["parent"]
        level <- map["level"]
        name <- map["name"]
        age <- map["age"]
        email <- map["email"]
        
        var strName = ""
        if let name = name {
            if name.hasPrefix("@") {
                strName = name.deletingPrefix("@")
            }
            else{
                strName = name
            }
        }
        name = strName
        
        var strEmail = ""
        if let email = email {
            if email.hasPrefix("@") {
                strEmail = email.deletingPrefix("@")
            }
            else{
                strEmail = email
            }
        }
        email = strEmail
    }
    
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

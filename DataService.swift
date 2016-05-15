//
//  DataService.swift
//  
//
//  Created by Bandi Anirudh on 14/05/16.
//
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "https://walkin.firebaseio.com/")
    private var _USER_REF = Firebase(url: "https://walkin.firebaseio.com/users")
    
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    var FEED_REF: Firebase {
        return _FEED_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "https://walkin.firebaseio.com/").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
               
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
       
}

//
//  DataService.swift
//  SocialAppShowcase
//
//  Created by Kaloyan Petrov on 1/4/16.
//  Copyright © 2016 kaloyanpetrov. All rights reserved.
//

import Foundation
import Firebase


let BASE_URL = "https://social-app-showcase.firebaseio.com"
//This is a Singleton

class DataService {

    static let dataService = DataService()
    
    private var _REF_BASE = Firebase(url: BASE_URL)
    private var _REF_POSTS = Firebase(url: "\(BASE_URL)/posts")
    private var _REF_USERS = Firebase(url: "\(BASE_URL)/users")
    
    
    //the public base ref
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }

    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = Firebase(url: "\(BASE_URL)").childByAppendingPath("users").childByAppendingPath(uid)
        
        return user
        
    }

    func createFirebaseUser(uid: String, user: Dictionary<String, String>){
    
        REF_USERS.childByAppendingPath(uid).setValue(user)
    
    }
    
   
    
}
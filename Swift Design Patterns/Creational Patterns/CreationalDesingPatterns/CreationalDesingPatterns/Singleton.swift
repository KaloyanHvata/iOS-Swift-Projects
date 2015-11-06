//
//  Singleton.swift
//  CreationalDesingPatterns
//
//  Created by Kaloyan Petrov on 11/6/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import Foundation

class SingletonC {
    
    class var sharedInstance: SingletonC {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: SingletonC? = nil
        }
        //A thread safe version of the instance
        
        dispatch_once(&Static.onceToken) {
            Static.instance = SingletonC()
        }
        return Static.instance!
    }
    
    private init() {
        print("CCC");
    }
    
}
//
//  CollectionTypesViewController.swift
//  SwiftBasics
//
//  Created by Kaloyan Petrov on 11/10/15.
//  Copyright © 2015 Kaloyan Petrov. All rights reserved.
//

import UIKit

class CollectionTypesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Arrays 
        let cars = ["Viper", "Mustang", "Lexus"]
        print(cars)
        
        //Dictionaries
        let items = [123:"Apples", 234:"Bananas", 345:"Oranges"]
        print(items)
        //Sets
        let numerts : Set = [123, 123, 124] //Returns 123 only one time, no repetitions with no order
        print(numerts)
        //Tuples ..not technicly a collection type but is commonly used for complitions
        let results = (123, "smartphone", 25.75)
        print(results)
        
        
    //Examples
        //ARRAYS
            //  var emptyArray : [String] = []  //Creating an empty array
            var dogNames = [String]()
            //populating
            dogNames.append("Jacky")
            dogNames += ["Barky", "Lucy"]
            dogNames.count //number of items
            dogNames.removeAtIndex(2)
        
        if dogNames.isEmpty{
            print("Array is empty")
        }else{
            print(dogNames)
          //  dogNames.removeAll() //Removes all the entries in the array
        }
        for(index, name)in dogNames.enumerate(){   //Shows you all the indexes
            print("\(index) : \(name)")
        }
        
        
        //DICTIONARIES
            //How to create empty Dictionaries
            var dictItems : [String : String] = [:]
            var dictProducts = [Int : String]()
        
            dictProducts[123] = "Product 1"
            dictItems["Hi"] = "Hello"
            //literal
            var states = ["NJ" : "New Jersey" ,"NY" : "New York", "CA" : "California","PA" : "Pennsylvania"]
            print(states["NJ"])
            states.updateValue("Commenwealth of Pennsylvania", forKey: "PA")
            print(states.count)
            states["PA"] = nil //Ereasing a KV pair
                //iterating
                for(abbrev, state) in states{    //Tuple
                    print("\(abbrev) is short for \(state)")
                }
        
        
        //SETS
            //How to create empty Sets
           // var teams : Set<String>
            var myBills : Set = ["electricity", "water", "heat", "internet"] //No repetitions
            myBills.count
            myBills.insert("cellphone")
            myBills.remove("cellphone")
                //interating
                for bills in myBills{
                    print(bills)
                }
        
        //TUPLES
        let tupleExample1 = ("Kaloyan", 26, 12.99, true)
        print(tupleExample1.0)
        print(tupleExample1.3)
        
        let car = getCarDetails()
        print(car)
        let (name, mph, top) = getCarDetails()
        print(name,mph,top)
    }
    
    //MARK : - Helper Methods

    func getCarDetails() -> (String, Int, Bool){
    
        let name = "Camaro"
        let speed = 140
        let isConvertable = true
        
        return (name,speed,isConvertable)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
   MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

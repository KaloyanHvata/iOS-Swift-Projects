//
//  JsonParserViewController.swift
//  JSON-XMLparsingDemo
//
//  Created by Kaloyan Petrov on 12/2/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class JsonParserViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "https://itunes.apple.com/search?term=taylor+swift&limit=50")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if let urlResults = data {
                
                do {
                    
                    let searchResults = try NSJSONSerialization.JSONObjectWithData(urlResults, options: NSJSONReadingOptions.MutableContainers)
                    
                    //print(searchResults)
                    
                    let list : NSArray? = searchResults["results"] as? NSArray
                    
                    //print(list)
                    
                    if list != nil {
                        for item : AnyObject in list! {
                            if let itemInfo = item as? NSDictionary {
                                if let title = itemInfo["trackCensoredName"] as? String {
                                    self.titles.append(title)
                                    
                                    print(title)
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        self.textView.text = String(self.titles)
                                        
                                    });
                                    
                                    
                                }
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error occured")
                    
                }
            }
            
        }
        
        task.resume()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

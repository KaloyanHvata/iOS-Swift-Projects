//
//  XmlParserViewController.swift
//  JSON-XMLparsingDemo
//
//  Created by Kaloyan Petrov on 12/2/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class XmlParserViewController: UIViewController,NSXMLParserDelegate {

    @IBOutlet weak var textView: UITextView!
    
    var itemName = ""
    var isValidItem = false
    var articleTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "https://www.apple.com/pr/feeds/pr.rss")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error ) -> Void in
            
            if error == nil{
                
                let downloadedContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                var xmlParser = NSXMLParser()
                
                xmlParser = NSXMLParser(data: data!)
                
                xmlParser.delegate = self
                
                xmlParser.parse()
                
              //  print(downloadedContent)
                
            }else{
                
                print(error)
            }
        }
            task.resume()
    }

    //MARK: - Helper Functions
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        itemName = elementName
  
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if itemName == "item"{
        
        isValidItem = true
        }
        
        if itemName == "title" && isValidItem == true{
            
            let betterString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if betterString != "" {
                articleTitles.append(betterString)
                
                 print(betterString)
                dispatch_async(dispatch_get_main_queue(),{
                    
                    self.textView.text = String(self.articleTitles)
                } );
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

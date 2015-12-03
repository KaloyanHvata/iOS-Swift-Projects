//
//  WebViewController.swift
//  WebViewsDemo
//
//  Created by Kaloyan Petrov on 12/3/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var localHTMLButton: UIButton!
    @IBOutlet weak var hTMLStringButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //From remote url
        let url = NSURL(string: "https://www.apple.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        appleButton.selected = true
        
        
        //From local url
        
        
        
        //From HTML string
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func appleButtonPressed(sender: AnyObject) {
        appleButton.selected = true
        localHTMLButton.selected = false
        hTMLStringButton.selected = false
        
        let url = NSURL(string: "https://www.apple.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)

        
    }

    @IBAction func localHtmlButtonPressed(sender: AnyObject) {
        appleButton.selected = false
        localHTMLButton.selected = true
        hTMLStringButton.selected = false
        
        let localPath = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        let localRequest = NSURLRequest(URL: localPath!)
        webView.loadRequest(localRequest)
        
    }

    @IBAction func htmlStringButtonPressed(sender: AnyObject) {
        appleButton.selected = false
        localHTMLButton.selected = false
        hTMLStringButton.selected = true
        
        let htmlString = "<html><body><h2>My String HTML Web Page!<p>This web page is created only by a String in the Xcode.</p></body></html>"
        webView.loadHTMLString(htmlString, baseURL: nil )
    }
   
    
}








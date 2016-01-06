//
//  FeedViewController.swift
//  SocialAppShowcase
//
//  Created by Kaloyan Petrov on 1/5/16.
//  Copyright © 2016 kaloyanpetrov. All rights reserved.
//

//ImageShack Key
//Key: 1ABZFRGUf0a42e13685b5c1afc8db2f49466db9e

import UIKit
import Firebase
import Alamofire


class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageSelectorImg: UIImageView!
    @IBOutlet weak var postField: MaterialTextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [Post]()
    var imagePicker:UIImagePickerController!
    var imageSelected = false
    
    static var imageCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 370
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        DataService.dataService.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            //Clearing up the array so we can populate it with the new data
            self.posts = []
            //Parsing the data
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for snap in snapshots {
                    print("Snap: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key , dictionary: postDict)
                        self.posts.append(post)
                        
                    }
                
                }
            
            }
            
            
            self.tableView.reloadData()
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostTableViewCell{
            //cancelling the previous request
            cell.request?.cancel()
            
            var img: UIImage?
            
            if let url = post.imageUrl {
              img = FeedViewController.imageCache.objectForKey(url) as? UIImage
                
            }
            
            cell.configureCell(post,img:img)
            
            return cell
        }else{
            return PostTableViewCell()
        }
 
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let post = posts[indexPath.row]
        
        if post.imageUrl == nil {
        
            return 150
        
        }else{
        
            return tableView.estimatedRowHeight
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion:nil)
        imageSelectorImg.image = image
        
        imageSelected = true
    }
    
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func makePost(sender: AnyObject) {
        
        if let txt = postField.text where txt != "" {
        
            if let img = imageSelectorImg.image where imageSelected == true {
            
                let urlStr = "https://post.imageshack.us/upload_api.php"
                let url = NSURL(string: urlStr)!
                let imgData = UIImageJPEGRepresentation(img, 0.2)!
                //Multiplatform request with Alamofire
                let keyData = "1ABZFRGUf0a42e13685b5c1afc8db2f49466db9e".dataUsingEncoding(NSUTF8StringEncoding)
                let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)
                
                Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
                    multipartFormData.appendBodyPart(data: imgData, name: "fileupload", fileName: "image",mimeType: "image/jpeg")
                    multipartFormData.appendBodyPart(data: keyData!, name: "key")
                    multipartFormData.appendBodyPart(data: keyJSON!, name: "format")
                    }) {encodingResult in
                        
                        switch encodingResult {
                            
                        case .Success(let upload, _, _):
                            
                            upload.responseJSON(completionHandler: { response in
                                
                                if let info = response.result.value as? Dictionary<String,AnyObject> {
                                    
                                    if let links = info["links"] as? Dictionary<String,AnyObject> {
                                        
                                        if let imageLink = links["image_link"] as? String {
                                            
                                            print("LINK: \(imageLink)")
                                            self.postToFirebase(imageLink)
                                            
                                        }
                                    }
                                }
                            })
                            
                        case.Failure(let error):
                            
                            print(error)
                        }
                }
                
            }else{
                self.postToFirebase(nil)
            }
        }
    }
    
    func postToFirebase(imageUrl: String?) {
    
        var post: Dictionary<String, AnyObject> = [
            "description" : postField.text!,
            "likes": 0
        ]
        
        if imageUrl != nil {
        
            post["imageUrl"] = imageUrl!
            
        }
        
        let firebasePost = DataService.dataService.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        postField.text = ""
        imageSelectorImg.image = UIImage(named: "camera")
        
        tableView.reloadData()
    }
}









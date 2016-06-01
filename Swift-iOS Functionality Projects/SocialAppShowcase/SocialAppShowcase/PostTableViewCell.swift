//
//  PostTableViewCell.swift
//  SocialAppShowcase
//
//  Created by Kaloyan Petrov on 1/5/16.
//  Copyright © 2016 kaloyanpetrov. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showCaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef: Firebase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Adding a tap gesture to likes image
        likeImage.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        
        
    }

    override func drawRect(rect: CGRect) {
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        showCaseImg.clipsToBounds = true
        
    }
    
    func configureCell(post: Post, img:UIImage?) {
        self.post = post
        
        likeRef = DataService.dataService.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        
        self.descriptionText.text = post.postDescription
        self.likesLabel.text = "\(post.likes)"
         //Use the cached image if there is one, otherwise download the image
        if post.imageUrl != nil {
            if img != nil{
            self.showCaseImg.image = img
            }else{
                //Must store the request so we can cancel it later if this cell is now out of the users view
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType:["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.showCaseImg.image = img
                        FeedViewController.imageCache.setObject(img, forKey: self.post!.imageUrl!)
                    }
                })
            }
        }else{
            self.showCaseImg.hidden = true
        }
        //Reference for likes
   
        likeRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                //This means we didnt like the specific post
                self.likeImage.image = UIImage(named: "heart-empty")
            }else{
                self.likeImage.image = UIImage(named: "heart-full")
            }
            
        })
    }
    func likeTapped(sender: UITapGestureRecognizer) {
        
        likeRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                
                //This means we didnt like the specific post
                self.likeImage.image = UIImage(named: "heart-full")
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
            }else{
                self.likeImage.image = UIImage(named: "heart-empty")
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
            }
              self.likesLabel.text = "\(self.post!.likes)"
        })
    }
    
    
  
    
}






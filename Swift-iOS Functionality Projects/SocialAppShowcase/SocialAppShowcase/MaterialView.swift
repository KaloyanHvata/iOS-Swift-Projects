//
//  MaterialView.swift
//  SocialAppShowcase
//
//  Created by Kaloyan Petrov on 12/28/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit



class MaterialView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor( red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(<#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
    }
}

//
//  CircleButton.swift
//  CustomTabBar
//
//  Created by eugene golovanov on 7/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    private var action = {}
    
    convenience init(frame: CGRect, image: UIImage, bgColor: UIColor, title: String, action: () -> ()) {
        self.init(frame: frame)
        
        self.action = action
        self.backgroundColor = bgColor
        self.setImage(image, forState: UIControlState.Normal)

        //Corner and shadow
        layer.cornerRadius = CGRectGetHeight(self.bounds)/2
        layer.shadowColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
        //Add target with closure
        self.addTarget(self, action: #selector(CircleButton.buttonTapped), forControlEvents: .TouchUpInside)
        
        // Label
        let titleLbl = UILabel(frame: CGRect(
            x: -self.frame.size.width/2,
            y: self.frame.size.height,
            width: self.frame.size.width*2,
            height: 30))
        titleLbl.textColor = UIColor.blackColor()
        titleLbl.text = title
        titleLbl.font = UIFont.systemFontOfSize(11)
        titleLbl.backgroundColor = UIColor.clearColor()
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.numberOfLines = 0
        self.addSubview(titleLbl)

        
    }
    
    
    
    
    
    
  @objc private func buttonTapped() {
        self.action()
    }
    
 
    
}


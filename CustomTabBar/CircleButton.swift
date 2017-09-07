//
//  CircleButton.swift
//  CustomTabBar
//
//  Created by eugene golovanov on 7/12/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    fileprivate var action = {}
    
    convenience init(frame: CGRect, image: UIImage, title: String, bgColor:UIColor, action: @escaping () -> ()) {
        self.init(frame: frame)
        
        self.action = action
        self.backgroundColor = bgColor
        self.setImage(image, for: .normal)
        
        //Make images full size
//        self.contentHorizontalAlignment = .fill
//        self.contentVerticalAlignment = .fill
//        self.imageView?.contentMode = .scaleAspectFit
        
        //Corner and shadow
        layer.cornerRadius = self.bounds.height/2
        layer.shadowColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        //Add target with closure
        self.addTarget(self, action: #selector(CircleButton.buttonTapped), for: .touchUpInside)
        
        // Label
        let titleLbl = UILabel(frame: CGRect(
            x: -self.frame.size.width/2,
            y: self.frame.size.height,
            width: self.frame.size.width*2,
            height: 30))
        
        titleLbl.textColor = UIColor.white
        titleLbl.text = title
        titleLbl.font = UIFont.systemFont(ofSize: 12)
        titleLbl.backgroundColor = UIColor.clear
        titleLbl.textAlignment = NSTextAlignment.center
        titleLbl.numberOfLines = 0
        
        titleLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLbl.sizeToFit()
        titleLbl.center.x = self.center.x
        
        titleLbl.layer.shadowColor = UIColor.black.cgColor
        titleLbl.layer.shadowOpacity = 0.7
        titleLbl.layer.shadowRadius = 2.0
        titleLbl.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        self.addSubview(titleLbl)
    }
    
    @objc fileprivate func buttonTapped() {
        self.action()
    }
}

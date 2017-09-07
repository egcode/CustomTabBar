//
//  MenuButton.swift
//  CustomTabBar
//
//  Created by Golovanov, Eugene on 9/6/17.
//  Copyright © 2017 eugene golovanov. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    
    fileprivate var action = {}
    
    convenience init(frame: CGRect, bgColor:UIColor, action: (() -> ())?) {
        self.init(frame: frame)
        
        if let a = action {
            self.action = a
        }
        self.backgroundColor = bgColor
        self.layer.cornerRadius = self.frame.height/2
        self.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-Thin", size: 60)
        self.setTitleColor(UIColor.darkGray, for: UIControlState.highlighted)
        self.setTitle("+", for: UIControlState())
        self.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0)
        self.addTarget(self, action: #selector(MenuButton.buttonTapped), for: UIControlEvents.touchUpInside)
    }
    
    @objc fileprivate func buttonTapped() {
        self.action()
    }
}


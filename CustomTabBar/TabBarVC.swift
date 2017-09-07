//
//  TabBarVC.swift
//
//
//  Created by Eugene Golovanov on 7/7/16.
//  Copyright © 2016 EG. All rights reserved.
//

import UIKit

let greenColor = UIColor(colorLiteralRed: 47/255, green: 189/255, blue: 119/255, alpha: 1.0)


class TabBarVC: UITabBarController {
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - custom UI properties
    
    var buttonsArray = Array<UIButton>()
    var circleButtonsSize:CGFloat = 50
    
    var menuButton = MenuButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var backgroundMenuButton = MenuButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    var blurEffectView = UIVisualEffectView()
    var effectsViewVisible = false
    var buttonsOrigin = CGPoint()
    var fakeButtonsOrigin = CGPoint()
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCustomUI()
    }
}

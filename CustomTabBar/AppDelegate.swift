//
//  AppDelegate.swift
//  CustomTabBar
//
//  Created by eugene golovanov on 7/7/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Getting CustomTabBarController
        guard let tabBarController = self.window?.rootViewController as? CustomTabBarController else {
            print("Got no root view controller for window")
            return false
        }

        //Circle buttons Size
        tabBarController.circleButtonsSize = 50
        
        //Adding Buttons
        let button1 = UIButton(frame: CGRectMake(
            0,
            0,
            tabBarController.circleButtonsSize,
            tabBarController.circleButtonsSize))
        button1.setTitle("1", forState: .Normal)
        button1.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button1.addTarget(self, action: #selector(AppDelegate.button1Pressed), forControlEvents: .TouchUpInside)
        button1.layer.cornerRadius = CGRectGetWidth(button1.frame)/2.0
        button1.backgroundColor = UIColor.orangeColor()
        button1.layer.masksToBounds = true
        button1.alpha = 0.0
        button1.enabled = false
        
        let button2 = UIButton(frame: CGRectMake(
            0,
            0,
            tabBarController.circleButtonsSize,
            tabBarController.circleButtonsSize))
        button2.setTitle("2", forState: .Normal)
        button2.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button2.addTarget(self, action: #selector(AppDelegate.button2Pressed), forControlEvents: .TouchUpInside)
        button2.enabled = false
        button2.alpha = 0.0
        button2.layer.cornerRadius = CGRectGetWidth(button2.frame)/2.0
        button2.backgroundColor = UIColor.orangeColor()
        button2.layer.masksToBounds = true
        
        
        let button3 = UIButton(frame: CGRectMake(
            0,
            0,
            tabBarController.circleButtonsSize,
            tabBarController.circleButtonsSize))
        button3.setTitle("3", forState: .Normal)
        button3.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button3.addTarget(self, action: #selector(AppDelegate.button3Pressed), forControlEvents: .TouchUpInside)
        button3.enabled = false
        button3.alpha = 0.0
        button3.layer.cornerRadius = CGRectGetWidth(button3.frame)/2.0
        button3.backgroundColor = UIColor.orangeColor()
        button3.layer.masksToBounds = true
        
        let button4 = UIButton(frame: CGRectMake(
            0,
            0,
            tabBarController.circleButtonsSize,
            tabBarController.circleButtonsSize))
        button4.setTitle("4", forState: .Normal)
        button4.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button4.addTarget(self, action: #selector(AppDelegate.button4Pressed), forControlEvents: .TouchUpInside)
        button4.enabled = false
        button4.alpha = 0.0
        button4.layer.cornerRadius = CGRectGetWidth(button3.frame)/2.0
        button4.backgroundColor = UIColor.orangeColor()
        button4.layer.masksToBounds = true

        
        let button5 = UIButton(frame: CGRectMake(
            0,
            0,
            tabBarController.circleButtonsSize,
            tabBarController.circleButtonsSize))
        button5.setTitle("5", forState: .Normal)
        button5.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button5.addTarget(self, action: #selector(AppDelegate.button5Pressed), forControlEvents: .TouchUpInside)
        button5.enabled = false
        button5.alpha = 0.0
        button5.layer.cornerRadius = CGRectGetWidth(button3.frame)/2.0
        button5.backgroundColor = UIColor.orangeColor()
        button5.layer.masksToBounds = true

        
        //Adding buttons
        tabBarController.buttonsArray.append(button5)
        tabBarController.buttonsArray.append(button4)
        tabBarController.buttonsArray.append(button3)
        tabBarController.buttonsArray.append(button2)
        tabBarController.buttonsArray.append(button1)
        
        return true
    }
    
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Actions
    
    
    func button1Pressed() {
        print("PRESSED 1-1-1")
    }
    
    func button2Pressed() {
        print("PRESSED 2-2-2")
    }
    func button3Pressed() {
        print("PRESSED 3-3-3")
    }

    func button4Pressed() {
        print("PRESSED 4-4-4")
    }
    func button5Pressed() {
        print("PRESSED 5-5-5")
    }
    
    
    
    
    
    
    
    
    
    


}


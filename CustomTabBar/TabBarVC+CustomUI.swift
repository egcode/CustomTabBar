//
//  TabBarVC+CustomUI.swift
//  CustomTabBar
//
//  Created by Golovanov, Eugene on 9/6/17.
//  Copyright © 2017 eugene golovanov. All rights reserved.
//

import UIKit

extension TabBarVC {
    
    func configureCustomUI() {
        
        //Middle button Origing
        self.buttonsOrigin = CGPoint(x: self.view.bounds.width/2 - menuButton.frame.size.width/2, y: self.view.bounds.height - menuButton.frame.height - 4)
        self.fakeButtonsOrigin = CGPoint(x: self.tabBar.bounds.width/2 - menuButton.frame.size.width/2, y: self.tabBar.bounds.height - menuButton.frame.height - 4)
        
        
        //Adjust items position
//        let verticalItemOffset:CGFloat = 5
//        if let items = self.tabBar.items {
//            let edgeInsets = UIEdgeInsets(top: -verticalItemOffset,
//                                          left: 0,
//                                          bottom: verticalItemOffset,
//                                          right: 0)
//            
//            items[0].imageInsets = edgeInsets
//            items[1].imageInsets = edgeInsets
//            items[3].imageInsets = edgeInsets
//            items[4].imageInsets = edgeInsets
//            
//            items[0].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -verticalItemOffset)
//            items[1].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -verticalItemOffset)
//            
//            items[3].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -verticalItemOffset)
//            items[4].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -verticalItemOffset)
//            
//        }

        //Removing built-in shadow
//        self.tabBar.shadowImage = UIImage()
//        self.tabBar.backgroundImage = UIImage(named: "tabBar")
        
        //Adding custom image
        let offset:CGFloat = 10
        let tabBg = UIImageView(frame: CGRect(x: 0, y: -offset, width: self.tabBar.frame.size.width, height: self.tabBar.frame.size.height+offset))
        tabBg.layer.shadowColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.5).cgColor
        tabBg.layer.shadowOpacity = 0.4
        tabBg.layer.shadowRadius = 0.4
        tabBg.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        tabBg.image = UIImage(named: "tabBar")
        tabBg.contentMode = UIViewContentMode.scaleAspectFill
        self.tabBar.insertSubview(tabBg, at: 0)
        
        //Effects View
        self.setupEffectsView()
        
        //Background Middle Button
        self.setupBackgroundMiddleButton(originPoint: fakeButtonsOrigin)
        
        //Foreground Middle Button
        self.setupForegroundMiddleButton(originPoint: buttonsOrigin)
        
        //Circle Buttons
        self.buttonsArray.removeAll()
        self.setupCircleButtons()
    }
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Setups
    
    fileprivate func setupEffectsView() {
        let someFrame = CGRect(
            x: 0,
            y: self.view.bounds.height-self.view.frame.size.height,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = someFrame
        self.blurEffectView.alpha = 0
        self.view.addSubview(blurEffectView)
        self.view.bringSubview(toFront: blurEffectView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuAction))
        blurEffectView.addGestureRecognizer(tap)
    }
    
    fileprivate func setupCircleButtons() {
        
        //Adding Buttons
        
        let buttonOne = CircleButton(frame: CGRect(x: 0, y: 0, width: self.circleButtonsSize, height: self.circleButtonsSize), image: UIImage(named:"message")!, title: "Button One", bgColor: UIColor.orange) {
            self.actionButtonOne()
        }
        let buttonTwo = CircleButton(frame: CGRect(x: 0, y: 0, width: self.circleButtonsSize, height: self.circleButtonsSize), image: UIImage(named:"appointment")!, title: "Button Two", bgColor: UIColor.blue) {
            self.actionButtonTwo()
        }
        let buttonThree = CircleButton(frame: CGRect(x: 0, y: 0, width: self.circleButtonsSize, height: self.circleButtonsSize), image: UIImage(named:"message")!, title: "Button Three", bgColor: UIColor.red) {
            self.actionButtonThree()
        }
        let buttonFour = CircleButton(frame: CGRect(x: 0, y: 0, width: self.circleButtonsSize, height: self.circleButtonsSize), image: UIImage(named:"appointment")!, title: "Button Four", bgColor: UIColor.green) {
            self.actionButtonFour()
        }
        let buttonFive = CircleButton(frame: CGRect(x: 0, y: 0, width: self.circleButtonsSize, height: self.circleButtonsSize), image: UIImage(named:"message")!, title: "Button Five", bgColor: UIColor.purple) {
            self.actionButtonFive()
        }
        self.buttonsArray.append(buttonFive)
        self.buttonsArray.append(buttonFour)
        self.buttonsArray.append(buttonThree)
        self.buttonsArray.append(buttonTwo)
        self.buttonsArray.append(buttonOne)
        
        //Align All Buttons
        for button in self.buttonsArray {
            button.frame = CGRect(
                x: self.tabBar.frame.size.width/2 - button.frame.size.width/2,
                y: self.buttonsOrigin.y,
                width: button.frame.size.width,
                height: button.frame.size.height)
            self.view.addSubview(button)
            button.alpha = 0.0
            button.isEnabled = false
        }
    }
    
    fileprivate func setupBackgroundMiddleButton(originPoint:CGPoint) {
        backgroundMenuButton = MenuButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), bgColor: greenColor, action: {
            self.menuAction()
        })
        backgroundMenuButton.frame.origin.x = originPoint.x
        backgroundMenuButton.frame.origin.y = originPoint.y
        
//        backgroundMenuButton.layer.shadowColor = UIColor.black.cgColor
//        backgroundMenuButton.layer.shadowOpacity = 0.7
//        backgroundMenuButton.layer.shadowRadius = 3.0
//        backgroundMenuButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        backgroundMenuButton.isHidden = false
        self.tabBar.insertSubview(backgroundMenuButton, at: 1)
        self.tabBar.bringSubview(toFront: backgroundMenuButton)
    }
    
    fileprivate func setupForegroundMiddleButton(originPoint:CGPoint) {
        menuButton = MenuButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), bgColor: greenColor, action: {
            self.menuAction()
        })
        menuButton.frame.origin.x = originPoint.x
        menuButton.frame.origin.y = originPoint.y
        
        menuButton.isHidden = true
        self.view.addSubview(menuButton)
        self.view.bringSubview(toFront: menuButton)
    }
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Actions
    
    func actionButtonOne() {
        self.selectedIndex = 0
        self.menuAction()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertOneButton(title: "Success", message: "Button one was tapped")
        }
    }
    
    func actionButtonTwo() {
        self.selectedIndex = 1
        self.menuAction()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertOneButton(title: "Success", message: "Button two was tapped")
        }
    }

    func actionButtonThree() {
        self.selectedIndex = 1
        self.menuAction()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertOneButton(title: "Success", message: "Button three was tapped")
        }
    }
    
    func actionButtonFour() {
        self.selectedIndex = 3
        self.menuAction()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertOneButton(title: "Success", message: "Button four was tapped")
        }
    }

    func actionButtonFive() {
        self.selectedIndex = 4
        self.menuAction()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alertOneButton(title: "Success", message: "Button five was tapped")
        }
    }

    
    func menuAction() {
        //Update origin, we do that because view size could change
        self.buttonsOrigin = CGPoint(x: self.view.bounds.width/2 - menuButton.frame.size.width/2, y: self.view.frame.height - menuButton.frame.height - 4)
        menuButton.frame.origin.y = self.buttonsOrigin.y
        
        //Bring Everything back to front
        self.view.bringSubview(toFront: self.blurEffectView)
        //Align All Buttons
        for button in self.buttonsArray {
            self.view.bringSubview(toFront: button)
        }
        self.view.bringSubview(toFront: self.menuButton)
        
        if self.effectsViewVisible == false {
            self.menuButton.isHidden = false
            
            self.effectsViewVisible = true
            self.animateButton(on: true)
            self.animateButtonsIntoSphere(buttonsArray: buttonsArray, buttonSize: self.circleButtonsSize)
            
        } else {
            self.effectsViewVisible = false
            self.animateButton(on: false)
            self.animateButtonsDissapear(buttonsArray: buttonsArray, buttonSize: self.circleButtonsSize, originMiddleButtonPoint: self.buttonsOrigin)
        }
        self.animateEffectsView(toVisibilty: self.effectsViewVisible)
    }
    
    //MARK: - Helpers

    func alertOneButton(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //------------------------------------------------------------------------------------------------------
    //MARK: - Animation
    
    fileprivate func animateButton(on:Bool) {
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 0.15
        rotationAnim.repeatCount = 1
        rotationAnim.fillMode = kCAFillModeForwards
        rotationAnim.isRemovedOnCompletion = false
        
        if on == true {
            rotationAnim.fromValue = 0.0
            rotationAnim.toValue = Float(Double.pi * 0.25)
        } else {
            rotationAnim.fromValue = Float(Double.pi * 0.25)
            rotationAnim.toValue = 0.0
        }
        self.menuButton.layer.add(rotationAnim, forKey: "turn")
        
        let scaleAnimate:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 1
        scaleAnimate.toValue = 1.1
        rotationAnim.repeatCount = 2
        scaleAnimate.duration = 0.05
        scaleAnimate.fillMode = kCAFillModeForwards
        scaleAnimate.autoreverses = true
        scaleAnimate.isRemovedOnCompletion = false
        scaleAnimate.setValue("scaleAnim", forKey: "name")
        scaleAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.menuButton.layer.add(scaleAnimate, forKey: "scale")
    }
    
    
    fileprivate func animateEffectsView (toVisibilty:Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = CGFloat(Int(NSNumber(value:toVisibilty)))
        }, completion: { (complete) in
            if complete {
                if toVisibilty == false {
                    self.menuButton.isHidden = true
                }
            }
        })
    }
    
    
    fileprivate func animateButtonsDissapear(buttonsArray:Array<UIButton>, buttonSize:CGFloat, originMiddleButtonPoint:CGPoint) {
        for i in 0..<buttonsArray.count {
            
            UIView.animate(withDuration: 0.3, animations: {
                let button = buttonsArray[i]
                button.frame = CGRect(x: self.view.frame.size.width/2 - self.circleButtonsSize/2, y: self.buttonsOrigin.y, width: self.circleButtonsSize, height: self.circleButtonsSize)
                button.alpha = 0.0
                button.isEnabled = false
            })
        }
    }
    
    fileprivate func animateButtonsIntoSphere(buttonsArray:Array<UIButton>, buttonSize:CGFloat) {
//        let bottomMargin:CGFloat = 50
        let bottomMargin:CGFloat = 20

        let numButt = buttonsArray.count
        let circleLayer = CAShapeLayer()
//        let radiusValue:CGFloat = 4.0
        let radiusValue:CGFloat = 3.0

        let radius = min(self.view.bounds.width, self.view.bounds.height)/radiusValue - circleLayer.lineWidth/radiusValue
        let startAngle = CGFloat(-Double.pi/2) * 2.0
        let endAngle = startAngle + CGFloat(Double.pi * 1.0)
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        for i in 0..<numButt {
            var angle = CGFloat(-Double.pi) / 2
            if numButt > 1 {
                angle = CGFloat(i) * CGFloat(-Double.pi) / CGFloat(numButt-1)
            }
            let point = CGPoint(x: radius * cos(angle), y: radius * sin(angle))
            path.move(to: point)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
                let button = buttonsArray[i]
                button.frame = CGRect(x: point.x+self.view.bounds.midX-buttonSize/2, y: point.y+self.view.bounds.height - (self.menuButton.frame.height + bottomMargin)-buttonSize/2, width: buttonSize, height: buttonSize)
                button.isEnabled = true
                button.alpha = 1.0
            }, completion: { (complete) in
            })
        }
        
    }
    
}

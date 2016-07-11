//
//  CustomTabBarController.swift
//  CustomTabBarController
//
//  Created by eugene golovanov on 7/7/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit


    let hartBlu = UIColor(red: 0.231, green: 0.741, blue: 0.792, alpha: 1.000)
    let hartBlueberry = UIColor(red: 0.290, green: 0.584, blue: 1.000, alpha: 1.000)



class CustomTabBarController: UITabBarController {
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Properties

    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    var blurEffectView = UIVisualEffectView()
    private var effectsViewVisible = false
    var buttonsArray = Array<UIButton>()
    let circleButtonsSize:CGFloat = 50
    var buttonsOrigin = CGPoint()
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Disable middle items
//        if let items = self.tabBar.items {
//            items[1].enabled = false
//        }
        //Adjust items position
        let verticalItemOffset:CGFloat = 5
        let horizontalItemOffset:CGFloat = 10
        if let items = self.tabBar.items {
            items[0].imageInsets = UIEdgeInsets(top: -verticalItemOffset,
                                                left: 0,
                                                bottom: verticalItemOffset,
                                                right: 0)
            items[2].imageInsets = UIEdgeInsets(top: -verticalItemOffset,
                                                left: 0,
                                                bottom: verticalItemOffset,
                                                right: 0)
            items[0].titlePositionAdjustment = UIOffset(horizontal: horizontalItemOffset, vertical: -verticalItemOffset)
            items[2].titlePositionAdjustment = UIOffset(horizontal: -horizontalItemOffset, vertical: -verticalItemOffset)
        }
        
        //Removing builting shadow
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage(named: "tabbarBg")
        
        //Adding custom image
        let offset:CGFloat = 20
        let tabBg = UIImageView(frame: CGRectMake(0, -offset, self.tabBar.frame.size.width, self.tabBar.frame.size.height+offset))
        tabBg.layer.shadowColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.5).CGColor
        tabBg.layer.shadowOpacity = 0.3
        tabBg.layer.shadowRadius = 0.3
        tabBg.layer.shadowOffset = CGSizeMake(0.0, -0.5)
        tabBg.image = UIImage(named: "tabbarBg")
        tabBg.contentMode = UIViewContentMode.ScaleAspectFill
        self.tabBar.insertSubview(tabBg, atIndex: 0)

        
        //Effects View
        self.setupEffectsView()
        
        self.buttonsOrigin = CGPoint(x: self.view.bounds.width/2 - menuButton.frame.size.width/2, y: self.view.bounds.height - menuButton.frame.height - 5)

        //Buttons
        let button1 = UIButton(frame: CGRectMake(
            self.view.frame.size.width/2 - self.circleButtonsSize/2,
            self.buttonsOrigin.y,
            self.circleButtonsSize,
            self.circleButtonsSize))
        button1.setTitle("1", forState: .Normal)
        button1.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button1.addTarget(self, action: #selector(CustomTabBarController.button1Pressed), forControlEvents: .TouchUpInside)
        button1.layer.cornerRadius = CGRectGetWidth(button1.frame)/2.0
        button1.backgroundColor = UIColor.orangeColor()
        button1.layer.masksToBounds = true
        button1.alpha = 0.0
        button1.enabled = false
        self.view.addSubview(button1)
        
        let button2 = UIButton(frame: CGRectMake(
            self.view.frame.size.width/2 - self.circleButtonsSize/2,
            self.buttonsOrigin.y,
            self.circleButtonsSize,
            self.circleButtonsSize))
        button2.setTitle("2", forState: .Normal)
        button2.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button2.addTarget(self, action: #selector(CustomTabBarController.button2Pressed), forControlEvents: .TouchUpInside)
        button2.enabled = false
        button2.alpha = 0.0
        button2.layer.cornerRadius = CGRectGetWidth(button2.frame)/2.0
        button2.backgroundColor = UIColor.orangeColor()
        button2.layer.masksToBounds = true
        self.view.addSubview(button2)

        
        let button3 = UIButton(frame: CGRectMake(
            self.view.frame.size.width/2 - self.circleButtonsSize/2,
            self.buttonsOrigin.y,
            self.circleButtonsSize,
            self.circleButtonsSize))
        button3.setTitle("3", forState: .Normal)
        button3.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        button3.addTarget(self, action: #selector(CustomTabBarController.button3Pressed), forControlEvents: .TouchUpInside)
        button3.enabled = false
        button3.alpha = 0.0
        button3.layer.cornerRadius = CGRectGetWidth(button3.frame)/2.0
        button3.backgroundColor = UIColor.orangeColor()
        button3.layer.masksToBounds = true
        self.view.addSubview(button3)

        self.buttonsArray = [button1, button2, button3]
        
        
        
        //Middle Button
        self.setupMiddleButton(originPoint: buttonsOrigin)
        
        
    }
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Setups
    
    func setupMiddleButton(originPoint originPoint:CGPoint) {
        menuButton.frame.origin.x = originPoint.x
        menuButton.frame.origin.y = originPoint.y
        menuButton.backgroundColor = hartBlu
        menuButton.layer.cornerRadius = menuButton.frame.height/2
        menuButton.titleLabel?.font = UIFont.systemFontOfSize(60)
        menuButton.setTitleColor(hartBlueberry, forState: UIControlState.Highlighted)
        menuButton.setTitle("+", forState: .Normal)
        menuButton.titleEdgeInsets = UIEdgeInsetsMake(-8, 0, 0, 0)
        self.view.addSubview(menuButton)
        self.view.bringSubviewToFront(menuButton)
        
        menuButton.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    
    
    
    
    
    func setupEffectsView() {
        
        let someFrame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: view.frame.size.height)

        
        // Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = someFrame
        blurEffectView.alpha = 0
        
        self.view.addSubview(blurEffectView)
        
//        // Label
//        let incomeMessageLabel = UILabel(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: blurEffectView.frame.size.width,
//            height: blurEffectView.frame.size.height))
//        incomeMessageLabel.textColor = UIColor.yellowColor()
//        incomeMessageLabel.text = "Super Blurred View"
//        incomeMessageLabel.font = UIFont.systemFontOfSize(22.0)
//        incomeMessageLabel.backgroundColor = UIColor.clearColor()
//        incomeMessageLabel.textAlignment = NSTextAlignment.Center
//        incomeMessageLabel.numberOfLines = 0
//        blurEffectView.contentView.addSubview(incomeMessageLabel)
        
    }

    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Actions
    
    func menuButtonAction(sender: UIButton) {
//        self.selectedIndex = 1
        
        if self.effectsViewVisible == false {
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
    
    
    
    func button1Pressed() {
        print("PRESSED 111")
    }
    
    func button2Pressed() {
        print("PRESSED 222")
    }
    func button3Pressed() {
        print("PRESSED 333")
    }


    //------------------------------------------------------------------------------------------------------
    //MARK: - Animation
    
    func animateButton(on on:Bool) {
        
    ////////rotate circle
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 0.15
        rotationAnim.repeatCount = 1
        rotationAnim.fillMode = kCAFillModeForwards
        rotationAnim.removedOnCompletion = false
        
        if on == true {
            rotationAnim.fromValue = 0.0
            rotationAnim.toValue = Float(M_PI * 0.75)
        } else {
            rotationAnim.fromValue = Float(M_PI * 0.75)
            rotationAnim.toValue = 0.0
        }
        self.menuButton.layer.addAnimation(rotationAnim, forKey: "turn")

    //////scale animation
        let scaleAnimate:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 1
        scaleAnimate.toValue = 1.1
        rotationAnim.repeatCount = 2
        scaleAnimate.duration = 0.05
        scaleAnimate.fillMode = kCAFillModeForwards
        scaleAnimate.autoreverses = true
        scaleAnimate.removedOnCompletion = false
        scaleAnimate.setValue("scaleAnim", forKey: "name")
        scaleAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.menuButton.layer.addAnimation(scaleAnimate, forKey: "scale")
    }
    
    
    
    func animateEffectsView (toVisibilty toVisibilty:Bool) {
        UIView.animateWithDuration(0.3) {
            self.blurEffectView.alpha = CGFloat(toVisibilty)
        }
    }

    
    
    func animateButtonsDissapear(buttonsArray buttonsArray:Array<UIButton>, buttonSize:CGFloat, originMiddleButtonPoint:CGPoint) {
        for i in 0..<buttonsArray.count {
            
            UIView.animateWithDuration(0.3, animations: {
                //Moving buttons
                let button = buttonsArray[i]
                button.frame = CGRectMake(self.view.frame.size.width/2 - self.circleButtonsSize/2, self.buttonsOrigin.y, self.circleButtonsSize, self.circleButtonsSize)
                button.alpha = 0.0
                button.enabled = false
                
            })
            
            
        }
    }
    
    
    
    func animateButtonsIntoSphere(buttonsArray buttonsArray:Array<UIButton>, buttonSize:CGFloat) {
        let bottomMargin:CGFloat = 50//margin of circle
        let numTicks = buttonsArray.count //number of buttons
        
        //Circle
        let circleLayer = CAShapeLayer()
        
        let radiusValue:CGFloat = 5.5
        let radius = min(self.view.bounds.width, self.view.bounds.height)/radiusValue - circleLayer.lineWidth/radiusValue
        let startAngle = CGFloat(-M_PI_2) * 2.0
        let endAngle = startAngle + CGFloat(M_PI * 1.0)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
//        //visual circle
//        let center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.height - menuButton.frame.height - bottomMargin)
//        circleLayer.lineWidth = 10
//        circleLayer.position = center
//        circleLayer.strokeColor = UIColor.redColor().CGColor
//        circleLayer.fillColor = UIColor.clearColor().CGColor
//        circleLayer.path = path.CGPath
//        circleLayer.strokeEnd = 1.0
//        self.view.layer.addSublayer(circleLayer)
        
        //Creating buttons on circle
        for i in 0..<buttonsArray.count {
            var angle = CGFloat(-M_PI) / 2
            if numTicks > 1 {
                angle = CGFloat(i) * CGFloat(-M_PI) / CGFloat(numTicks-1)
            }
            
            let degreeAngle: Double = Double(angle) * 180 / M_PI
            print("ANGLE:\(abs(degreeAngle))")
            
            let point = CGPoint(x: radius * cos(angle), y: radius * sin(angle))
            path.moveToPoint(point)
//            print("Point: \(point)")
            
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                //Moving buttons
                let button = buttonsArray[i]
                button.frame = CGRectMake(point.x+self.view.bounds.midX-buttonSize/2, point.y+self.view.bounds.height - (self.menuButton.frame.height + bottomMargin)-buttonSize/2, buttonSize, buttonSize)
                button.enabled = true
                button.alpha = 1.0
                }, completion: { (complete) in
            })
        }
        
    }
    
    
    
    
    
}




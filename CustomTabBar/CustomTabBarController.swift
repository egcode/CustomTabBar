//
//  MainHartTBC.swift
//  hart
//
//  Created by Jon Kim on 7/7/16.
//  Copyright © 2016 Hart. All rights reserved.
//

import UIKit

let hartBlu = UIColor(red: 0.231, green: 0.741, blue: 0.792, alpha: 1.000)
let hartBlueberry = UIColor(red: 0.290, green: 0.584, blue: 1.000, alpha: 1.000)


class CustomTabBarController: UITabBarController {
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Properties
    
    //Public
    var buttonsArray = Array<UIButton>()
    var circleButtonsSize:CGFloat = 50
    
    //Private
    private var menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    private var fakeMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    private var blurEffectView = UIVisualEffectView()
    private var effectsViewVisible = false
    private var buttonsOrigin = CGPoint()
    private var fakeButtonsOrigin = CGPoint()
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Middle button Origing
        self.buttonsOrigin = CGPoint(x: self.view.bounds.width/2 - menuButton.frame.size.width/2, y: self.view.bounds.height - menuButton.frame.height - 5)
        self.fakeButtonsOrigin = CGPoint(x: self.tabBar.bounds.width/2 - menuButton.frame.size.width/2, y: self.tabBar.bounds.height - menuButton.frame.height - 5)
        
        
        //Adjust items position
        let verticalItemOffset:CGFloat = 2
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
        self.tabBar.backgroundImage = UIImage(named: "tabBar")
        
        //Adding custom image
        let offset:CGFloat = 20
        let tabBg = UIImageView(frame: CGRectMake(0, -offset, self.tabBar.frame.size.width, self.tabBar.frame.size.height+offset))
        tabBg.layer.shadowColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.5).CGColor
        tabBg.layer.shadowOpacity = 0.3
        tabBg.layer.shadowRadius = 0.3
        tabBg.layer.shadowOffset = CGSizeMake(0.0, -0.5)
        tabBg.image = UIImage(named: "tabBar")
        tabBg.contentMode = UIViewContentMode.ScaleAspectFill
        self.tabBar.insertSubview(tabBg, atIndex: 0)
        
        //Effects View
        self.setupEffectsView()
        
        //Fake Middle Button
        self.setupFakeMiddleButton(originPoint: fakeButtonsOrigin)
        
        //Middle Button
        self.setupMiddleButton(originPoint: buttonsOrigin)
        
        //Circle Buttons
        self.buttonsArray.removeAll()
        self.setupCircleButtons()
        
//        //Tabbar observer
//        self.tabBar.addObserver(self, forKeyPath: "hidden", options: [], context: nil)

        
    }
    
    
//------------------------------------------------------------------------------------------------------
//MARK: - Tab Bar Observer

//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "hidden" {
//            print("Tabar vis:\(self.tabBar.hidden)")
//            if self.tabBar.hidden {
//                self.menuButton.hidden = true
//            } else {
//                self.menuButton.hidden = false
//                self.view.bringSubviewToFront(menuButton)
//
//            }
//        }
//    }
//
//    deinit {
//        self.tabBar.removeObserver(self, forKeyPath: "hidden")
//    }

    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Setups
    
    private func setupEffectsView() {
        let someFrame = CGRect(
            x: 0,
            y: CGRectGetHeight(self.view.bounds)-self.view.frame.size.height,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = someFrame
        self.blurEffectView.alpha = 0
        self.view.addSubview(blurEffectView)
        self.view.bringSubviewToFront(blurEffectView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuButtonAction))
        blurEffectView.addGestureRecognizer(tap)

        
    }
    
    
    
    
    private func setupCircleButtons() {
        
        //Circle buttons Size
        self.circleButtonsSize = 50
        
        
        
        //Adding Buttons
        //Button 1
        let button1 = CircleButton(frame: CGRectMake(0, 0, self.circleButtonsSize, self.circleButtonsSize), image: UIImage(named:"appointment")!, bgColor: UIColor.redColor(), title: "appointment") {
            print("111")
        }
        
        //Button 2
        let button2 = CircleButton(frame: CGRectMake(0, 0, self.circleButtonsSize, self.circleButtonsSize), image: UIImage(named:"message")!, bgColor: UIColor.orangeColor(), title: "message") {
            print("222")
        }
        
        
        //Button 3
        let button3 = CircleButton(frame: CGRectMake(0, 0, self.circleButtonsSize, self.circleButtonsSize), image: UIImage(named:"message")!, bgColor: UIColor.blueColor(), title: "some title") {
            print("333")
        }
        
        
        
        //Adding buttons
        //        self.buttonsArray.append(button5)
        //        self.buttonsArray.append(button4)
        self.buttonsArray.append(button3)
        self.buttonsArray.append(button2)
        self.buttonsArray.append(button1)
        
        //Align All Buttons
        for button in self.buttonsArray {
            button.frame = CGRectMake(
                self.tabBar.frame.size.width/2 - button.frame.size.width/2,
                self.buttonsOrigin.y,
                button.frame.size.width,
                button.frame.size.height)
            self.view.addSubview(button)
            button.alpha = 0.0
            button.enabled = false
        }
    }
    
    
    
    
    
    
    
    
    
    private func setupFakeMiddleButton(originPoint originPoint:CGPoint) {
        fakeMenuButton.hidden = false
        fakeMenuButton.frame.origin.x = originPoint.x
        fakeMenuButton.frame.origin.y = originPoint.y
        fakeMenuButton.backgroundColor = hartBlu
        fakeMenuButton.layer.cornerRadius = fakeMenuButton.frame.height/2
        fakeMenuButton.titleLabel?.font = UIFont.init(name: "Courier", size: 60)
        fakeMenuButton.setTitleColor(hartBlueberry, forState: UIControlState.Highlighted)
        fakeMenuButton.setTitle("+", forState: .Normal)
        fakeMenuButton.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0)
        fakeMenuButton.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.tabBar.insertSubview(fakeMenuButton, atIndex: 1)
        self.tabBar.bringSubviewToFront(fakeMenuButton)
    }
    
    
    
    private func setupMiddleButton(originPoint originPoint:CGPoint) {
        menuButton.hidden = true
        menuButton.frame.origin.x = originPoint.x
        menuButton.frame.origin.y = originPoint.y
        menuButton.backgroundColor = hartBlu
        menuButton.layer.cornerRadius = menuButton.frame.height/2
        menuButton.titleLabel?.font = UIFont.init(name: "Courier", size: 60)
        menuButton.setTitleColor(hartBlueberry, forState: UIControlState.Highlighted)
        menuButton.setTitle("+", forState: .Normal)
        menuButton.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0)
        menuButton.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(menuButton)
        self.view.bringSubviewToFront(menuButton)
    }
    
    
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        
        
        //Update origin, we do that because view size could change
        self.buttonsOrigin = CGPoint(x: self.view.bounds.width/2 - menuButton.frame.size.width/2, y: self.view.frame.height - menuButton.frame.height - 5)
        menuButton.frame.origin.y = self.buttonsOrigin.y

        //Bring Everything back to front
        self.view.bringSubviewToFront(self.blurEffectView)
        //Align All Buttons
        for button in self.buttonsArray {
            self.view.bringSubviewToFront(button)
        }
        self.view.bringSubviewToFront(self.menuButton)
        
        
        
        if self.effectsViewVisible == false {
            self.menuButton.hidden = false
            
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
    
    
    //------------------------------------------------------------------------------------------------------
    //MARK: - Animation
    
    private func animateButton(on on:Bool) {
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.duration = 0.15
        rotationAnim.repeatCount = 1
        rotationAnim.fillMode = kCAFillModeForwards
        rotationAnim.removedOnCompletion = false
        
        if on == true {
            rotationAnim.fromValue = 0.0
            rotationAnim.toValue = Float(M_PI * 0.25)
        } else {
            rotationAnim.fromValue = Float(M_PI * 0.25)
            rotationAnim.toValue = 0.0
        }
        self.menuButton.layer.addAnimation(rotationAnim, forKey: "turn")
        
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
    
    
    private func animateEffectsView (toVisibilty toVisibilty:Bool) {
        UIView.animateWithDuration(0.3, animations: {
            self.blurEffectView.alpha = CGFloat(toVisibilty)
        }) { (complete) in
            if complete {
                if toVisibilty == false {
                    self.menuButton.hidden = true
                }
            }
        }
    }
    
    
    private func animateButtonsDissapear(buttonsArray buttonsArray:Array<UIButton>, buttonSize:CGFloat, originMiddleButtonPoint:CGPoint) {
        for i in 0..<buttonsArray.count {
            
            UIView.animateWithDuration(0.3, animations: {
                let button = buttonsArray[i]
                button.frame = CGRectMake(self.view.frame.size.width/2 - self.circleButtonsSize/2, self.buttonsOrigin.y, self.circleButtonsSize, self.circleButtonsSize)
                button.alpha = 0.0
                button.enabled = false
            })
        }
    }
    
    private func animateButtonsIntoSphere(buttonsArray buttonsArray:Array<UIButton>, buttonSize:CGFloat) {
        let bottomMargin:CGFloat = 50
        let numButt = buttonsArray.count
        let circleLayer = CAShapeLayer()
        let radiusValue:CGFloat = 4.0
        let radius = min(self.view.bounds.width, self.view.bounds.height)/radiusValue - circleLayer.lineWidth/radiusValue
        let startAngle = CGFloat(-M_PI_2) * 2.0
        let endAngle = startAngle + CGFloat(M_PI * 1.0)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        for i in 0..<numButt {
            var angle = CGFloat(-M_PI) / 2
            if numButt > 1 {
                angle = CGFloat(i) * CGFloat(-M_PI) / CGFloat(numButt-1)
            }
            let point = CGPoint(x: radius * cos(angle), y: radius * sin(angle))
            path.moveToPoint(point)
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                let button = buttonsArray[i]
                button.frame = CGRectMake(point.x+self.view.bounds.midX-buttonSize/2, point.y+self.view.bounds.height - (self.menuButton.frame.height + bottomMargin)-buttonSize/2, buttonSize, buttonSize)
                button.enabled = true
                button.alpha = 1.0
                }, completion: { (complete) in
            })
        }
        
    }    
}


////------------------------------------------------------------------------------------------------------
////------------------------------------------------------------------------------------------------------
////MARK: -
////MARK: - Extension
//
//extension UITabBar {
//    
//    @nonobjc static var menuVisible = false
//    
//    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        
//        if self.hidden == true || UITabBar.menuVisible == false {
//            return super.hitTest(point, withEvent: event)
//        }
//        
//        
//        for subview in self.subviews.reverse() {
//            
//            if subview is UIButton {
//                if let button = subview as? UIButton {
//                    if button.enabled == true &&  button.alpha == 1.0 {
//                        let pointForTargetView: CGPoint = button.convertPoint(point, fromView: self)
//                        if CGRectContainsPoint(button.bounds, pointForTargetView) {
//                            //                            print("BUTTON")
//                            return button
//                        }
//                    }
//                }
//            }
//            else if subview.isKindOfClass(UIVisualEffectView) {
//                if let effectsView = subview as? UIVisualEffectView {
//                    if effectsView.alpha == 1.0 {
//                        let pointForTargetView: CGPoint = effectsView.convertPoint(point, fromView: self)
//                        if CGRectContainsPoint(effectsView.bounds, pointForTargetView) {
//                            //                            print("EFFECTS")
//                            return effectsView
//                        }
//                    }
//                }
//            }
//            else if subview.isKindOfClass(CircleButton) {
//                if let button = subview as? CircleButton {
//                    if button.enabled == true &&  button.alpha == 1.0 {
//                        let pointForTargetView: CGPoint = button.convertPoint(point, fromView: self)
//                        if CGRectContainsPoint(button.bounds, pointForTargetView) {
//                            //                            print("Circle")
//                            return button
//                        }
//                    }
//                }
//            }
//            
//            
//            
//        }
//        
//        return super.hitTest(point, withEvent: event)
//        
//    }
//    
//}


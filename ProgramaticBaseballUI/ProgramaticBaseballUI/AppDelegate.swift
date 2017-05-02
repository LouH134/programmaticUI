//
//  AppDelegate.swift
//  ProgramaticBaseballUI
//
//  Created by Louis Harris on 4/26/17.
//  Copyright © 2017 Louis Harris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = ViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    class ViewController:UIViewController,UIGestureRecognizerDelegate
    {
        var myBackgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        let bodyImageView = UIImageView(frame: CGRect(x: 200, y: 300, width: 150, height: 200))
        var headImageView = UIImageView(frame: CGRect(x: 225, y: 200, width: 100, height: 100))
        var baseballImageView = UIImageView(frame: CGRect(x: 300, y: 100, width: 150, height: 150))
        var syringeImageView = UIImageView(frame: CGRect(x: 325, y: 265, width: 50, height: 75))
        var calcImageView = UIImageView(frame: CGRect(x: 0, y: 200, width: 125, height: 200))
        let squareImageView = UIImageView(frame: CGRect(x: 363, y: 670, width: 50, height: 50))
        let backgrounds = ["GiantsField", "Yankee", "Shea"]
        var currentBackgroundImageIndex = 0
        
        let firstNumberTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        let secondNumberTextField = UITextField(frame: CGRect(x: 0, y: 50, width: 120, height: 30))
        let equalsButton = UIButton(frame: CGRect(x: 45, y: 150, width: 30, height: 30))
        let plusSign = UILabel(frame: CGRect(x: 40, y: 35, width: 10, height: 10))
        let sum = UILabel(frame: CGRect(x: 0, y: 100, width: 120, height: 30))
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeBackGroundImage))
            swipeRight.direction = .right
            swipeRight.delegate = self
            self.myBackgroundImageView.isUserInteractionEnabled = true
            self.myBackgroundImageView.addGestureRecognizer(swipeRight)
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeBackGroundImage))
            swipeLeft.direction = .left
            swipeLeft.delegate = self
            self.myBackgroundImageView.addGestureRecognizer(swipeLeft)
            
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(changeHeadSize))
            pinch.delegate = self
            self.headImageView.isUserInteractionEnabled = true
            self.headImageView.addGestureRecognizer(pinch)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(moveBaseball))
            pan.delegate = self
            self.baseballImageView.isUserInteractionEnabled = true
            self.baseballImageView.addGestureRecognizer(pan)
            
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateBaseball))
            rotate.delegate = self
            self.baseballImageView.addGestureRecognizer(rotate)
            
            view.addSubview(myBackgroundImageView)
            view.addSubview(bodyImageView)
            view.addSubview(headImageView)
            view.addSubview(baseballImageView)
            view.addSubview(syringeImageView)
            view.addSubview(calcImageView)
            view.addSubview(squareImageView)
            
            myBackgroundImageView.image = UIImage(named: "GiantsField")
            bodyImageView.image = UIImage(named: "body")
            headImageView.image = UIImage(named: "barrybondshead")
            baseballImageView.image = UIImage(named: "Baseball")
            syringeImageView.image = UIImage(named: "syringe")
            
            syringeImageView.isHidden = true
            squareImageView.backgroundColor = .orange
            
            createButton()
            calculator()
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
//        
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            
            coordinator.animateAlongsideTransition(in: view, animation: { (context) in
                
                
            }) { (context) in
                
                if UIApplication.shared.statusBarOrientation.isLandscape {
                    print("LANDSCAPE")
                    
                    //put square in bottom right
                    self.squareImageView.frame = CGRect(x: 670, y: 363, width: 50, height: 50)
                    
                } else if UIApplication.shared.statusBarOrientation.isPortrait {
                    print("Portrait")
                    //put square in bottom right
                    self.squareImageView.frame = CGRect(x: 363, y: 670, width: 50, height: 50)
                }
                
            }
            
        }
        
        func changeBackGroundImage(gesture:UIGestureRecognizer)
        {
            if self.currentBackgroundImageIndex < backgrounds.count - 1
            {
                self.currentBackgroundImageIndex += 1
            }else{
                self.currentBackgroundImageIndex = 0
            }
            
            self.myBackgroundImageView.image = UIImage(named: backgrounds[currentBackgroundImageIndex])
            self.myBackgroundImageView.contentMode = .scaleAspectFill
            
        }
        
        func changeHeadSize(sender:UIPinchGestureRecognizer)
        {
            self.headImageView.transform = self.headImageView.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
        }
        
        func moveBaseball(sender:UIPanGestureRecognizer)
        {
            sender.view?.center = sender.location(in: sender.view?.superview)
        }
        
        func rotateBaseball(sender:UIRotationGestureRecognizer)
        {
            self.baseballImageView.transform = self.baseballImageView.transform.rotated(by: sender.rotation)
            sender.rotation = 0.5
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        func makeSyringeAppear(sender:UILongPressGestureRecognizer)
        {
            if sender.state == .began
                
            {
                self.syringeImageView.isHidden = false
                self.bodyImageView.transform = self.bodyImageView.transform.scaledBy(x: 1.5, y: 1.5)
            }else if sender.state == .ended {
                self.syringeImageView.isHidden = true
                self.bodyImageView.transform = self.bodyImageView.transform.scaledBy(x: 0.67, y: 0.67)
            }
        }
        
        func createButton()
        {
            let button = UIButton(frame: CGRect(x: self.view.bounds.size.width/2, y: 35, width: 100, height: 25))
            button.setTitle("Juice Up", for: UIControlState.normal)
            button.backgroundColor = .orange
            let longpress = UILongPressGestureRecognizer(target: self, action: #selector(makeSyringeAppear))
            button.addGestureRecognizer(longpress)
            self.view.addSubview(button)
        }
        
        func calculator()
        {
            self.calcImageView.isUserInteractionEnabled = true
            self.calcImageView.backgroundColor = .yellow
            
            self.plusSign.text = "+"
            self.equalsButton.setTitle("=", for: UIControlState.normal)
            self.equalsButton.backgroundColor = .green
            self.equalsButton.setTitleColor(.black, for: UIControlState.normal)
            
            
            let placeHolderString = "Enter Number"
            self.firstNumberTextField.placeholder = placeHolderString
            self.secondNumberTextField.placeholder = placeHolderString
            self.firstNumberTextField.borderStyle = .line
            self.secondNumberTextField.borderStyle = .line
            
            
            
            //when equals button is tapped
            let tappress = UITapGestureRecognizer(target: self, action: #selector(addNumbers))
            equalsButton.addGestureRecognizer(tappress)
            
            self.calcImageView.addSubview(self.firstNumberTextField)
            self.calcImageView.addSubview(self.plusSign)
            self.calcImageView.addSubview(self.secondNumberTextField)
            self.calcImageView.addSubview(self.equalsButton)
            self.calcImageView.addSubview(self.sum)
            
        }
        
        func addNumbers()
        {
            if firstNumberTextField.hasText && secondNumberTextField.hasText
            {
                //convert textfields text to int
                let firstNumber = Int(firstNumberTextField.text!)
                let secondNumber = Int(secondNumberTextField.text!)
                //add them together
                let sum = firstNumber! + secondNumber!
                let answer = "\(sum)"
                //show sum in sum label             
                self.sum.text = answer
            }
        }
    }


}


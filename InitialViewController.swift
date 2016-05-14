//
//  InitialViewController.swift
//  walk-in
//
//  Created by Bandi Anirudh on 13/05/16.
//  Copyright © 2016 Xlabs. All rights reserved.
//

import UIKit

let screenHeight = UIScreen.mainScreen().bounds.height
let screenWidth = UIScreen.mainScreen().bounds.width

class InitialViewController: UIViewController {
    
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var facebookLogin: UIButton!
    @IBOutlet var tncButton: UIButton!
    
    //constraints
    
    @IBOutlet var logoImageWidth: NSLayoutConstraint!
    @IBOutlet var logoImageHeight: NSLayoutConstraint!
    
    
    @IBOutlet var tncButtonWidth: NSLayoutConstraint!
    
    
    @IBOutlet var topToLogoBottom: NSLayoutConstraint!
    
    
    @IBOutlet var logoToSignUp: NSLayoutConstraint!
    
    @IBOutlet var signUpButtonWidth: NSLayoutConstraint!
    
    @IBOutlet var buttonHeight: NSLayoutConstraint!
    
    @IBOutlet var signUpToFacebook: NSLayoutConstraint!
    
    @IBOutlet var buttonsGap: NSLayoutConstraint!
    @IBOutlet var facebookToTnc: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(screenHeight)
        print(screenWidth)
        print(topToLogoBottom.constant)
        // Do any additional setup after loading the view.
        backgroundImage.image = UIImage(named: "ass.jpg")

        
       logoImageWidth.constant = 0.4 * screenWidth
       logoImageHeight.constant = logoImageWidth.constant
        buttonsGap.constant = 0.05 * screenWidth
       buttonHeight.constant = 0.07 * screenHeight
        topToLogoBottom.constant  = -0.4 * screenHeight
        
        logoToSignUp.constant = 0.3 * screenHeight
        
        signUpToFacebook.constant = 0.025 * screenHeight
        
        facebookToTnc.constant = 0.025 * screenHeight
        
        signUpButton.backgroundColor = UIColor.blackColor()
        loginButton.backgroundColor = UIColor.blackColor()
        facebookLogin.backgroundColor = UIColor.blackColor()
        //tncButton.backgroundColor = UIColor.blackColor()
        logoImage.backgroundColor = UIColor.blackColor()
        
        let cornerRadius : CGFloat = 5.0
        
        logoImage.layer.masksToBounds = true
        logoImage.layer.cornerRadius = logoImageHeight.constant / 2
        
        
        
        
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = cornerRadius
        signUpButton.setTitle("SIGN UP", forState: .Normal)
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.setTitle("LOGIN", forState: .Normal)
        
        facebookLogin.layer.masksToBounds = true
        facebookLogin.layer.cornerRadius = cornerRadius
        
        tncButton.setTitle("Terms and Conditions", forState: .Normal)
        
        let fb = UIImageView(frame: CGRect(x: facebookLogin.bounds.origin.x + 0.07 * screenWidth, y: facebookLogin.bounds.origin.y + 0.01 * screenHeight , width: facebookLogin.bounds.height, height: facebookLogin.bounds.height))
        print(fb.bounds.origin)
        print(facebookLogin.bounds.origin)
        
        fb.contentMode = UIViewContentMode.ScaleAspectFill
        
        fb.image = UIImage(named: "f.png")
        
    
        
        facebookLogin.addSubview(fb)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

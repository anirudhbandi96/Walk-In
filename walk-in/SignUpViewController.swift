//
//  SignUpViewController.swift
//  walk-in
//
//  Created by Bandi Anirudh on 14/05/16.
//  Copyright © 2016 Xlabs. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UITextFieldDelegate {

    
    
    @IBOutlet var signUp: UIButton!
    @IBOutlet var blurredView: UIView!
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    @IBAction func signUp(sender: AnyObject) {
    }
    
    @IBOutlet var viewWidth: NSLayoutConstraint!
    
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet var regToWelcome: NSLayoutConstraint!
    @IBOutlet var welcomeToNext: NSLayoutConstraint!
    @IBOutlet var usernameToAboveLabel: NSLayoutConstraint!
    @IBOutlet var usernameToPassword: NSLayoutConstraint!
    @IBOutlet var passwordToSignUp: NSLayoutConstraint!
    
    
    @IBOutlet var topToViewTop: NSLayoutConstraint!
    
    
    @IBOutlet var regLabelHeight: NSLayoutConstraint!
    @IBOutlet var welcomeLabelHeight: NSLayoutConstraint!
    @IBOutlet var weLabelHeight: NSLayoutConstraint!
    @IBOutlet var passwordTextFieldHeight: NSLayoutConstraint!
    @IBOutlet var signUpButtonHeight: NSLayoutConstraint!
    @IBOutlet var signUpButtonWidth: NSLayoutConstraint!
    @IBOutlet var usernameTextFieldWidth: NSLayoutConstraint!
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.username.delegate = self
        self.password.delegate = self
        
        self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        viewWidth.constant = 0.8 * screenWidth
        viewHeight.constant = 0.6 * screenHeight
        
        regToWelcome.constant = viewHeight.constant * 0.01
        welcomeToNext.constant = viewHeight.constant * 0.01
        usernameToAboveLabel.constant = viewHeight.constant * 0.05
        usernameToPassword.constant = viewHeight.constant * 0.05
        passwordToSignUp.constant = viewHeight.constant * 0.05
        
        topToViewTop.constant = 0.15 * screenHeight
        
        regLabelHeight.constant = viewHeight.constant * 0.1
        welcomeLabelHeight.constant = viewHeight.constant * 0.1
        weLabelHeight.constant = viewHeight.constant * 0.1
        passwordTextFieldHeight.constant = viewHeight.constant * 0.1
        signUpButtonHeight.constant = viewHeight.constant * 0.1
        signUpButtonWidth.constant = viewWidth.constant * 0.3
        
        username.layer.masksToBounds = true
        username.layer.cornerRadius = 20.0
        
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 20.0
        
        usernameTextFieldWidth.constant = 0.95 * viewWidth.constant
        
        
        let usernameIcon = UIImageView(image: UIImage(named: "user.png"))
        usernameIcon.contentMode = UIViewContentMode.ScaleToFill
        
        let leftView = UIView()
        leftView.addSubview(usernameIcon)
        
        leftView.frame = CGRectMake(0, 0, usernameTextFieldWidth.constant * 0.18, passwordTextFieldHeight.constant * 0.9)
        //let frame = CGRectMake(0,0, usernameTextFieldWidth.constant * 0.15,  passwordTextFieldHeight.constant * 0.9)
        let frame = CGRectMake(0,0, passwordTextFieldHeight.constant * 0.9 ,  passwordTextFieldHeight.constant * 0.9)
        
        
        usernameIcon.frame = frame
        usernameIcon.center = leftView.center
        
        
        self.username.leftView = leftView
        self.username.leftViewMode = UITextFieldViewMode.Always
        username.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName : UIColor.blackColor()])
        
        
        
        
        
        let passwordIcon = UIImageView(image : UIImage(named : "pass.png"))
        passwordIcon.contentMode = UIViewContentMode.ScaleToFill
        
        let leftView2 = UIView()
        leftView2.addSubview(passwordIcon)
        
        leftView2.frame = CGRectMake(0, 0, usernameTextFieldWidth.constant * 0.18, passwordTextFieldHeight.constant * 0.9)
        
        passwordIcon.frame = frame
        passwordIcon.center = leftView2.center
        
        self.password.leftView = leftView2
        self.password.leftViewMode = UITextFieldViewMode.Always
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : UIColor.blackColor()])
        password.secureTextEntry = true
        
        
        signUp.layer.masksToBounds = true
        signUp.layer.cornerRadius = 6.0
        
        
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.flag == 0 {
             topToViewTop.constant -= keyboardSize.height/2.5
                self.flag = 1
                UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.flag == 1 {
            topToViewTop.constant += keyboardSize.height/2.5
                self.flag = 0
                UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

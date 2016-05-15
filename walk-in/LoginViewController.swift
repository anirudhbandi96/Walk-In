//
//  LoginViewController.swift
//  walk-in
//
//  Created by Bandi Anirudh on 15/05/16.
//  Copyright © 2016 Xlabs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var topToBlurredView: NSLayoutConstraint!
    @IBOutlet var blurredView: UIView!
    
    @IBOutlet var blurredViewWidth: NSLayoutConstraint!

    @IBOutlet var blurredViewHeight: NSLayoutConstraint!
    @IBOutlet var topToLoginLabel: NSLayoutConstraint!
    
    @IBOutlet var textFieldWidth: NSLayoutConstraint!
    @IBOutlet var loginLabelToEmail: NSLayoutConstraint!
    @IBOutlet var textFieldHeight: NSLayoutConstraint!
    @IBOutlet var emailToPassword: NSLayoutConstraint!
    @IBOutlet var passwordToLoginButton: NSLayoutConstraint!
    @IBOutlet var loginButtonToForgot: NSLayoutConstraint!
    
    
    @IBOutlet var loginLabelHeight: NSLayoutConstraint!
    @IBOutlet var loginButtonWidth: NSLayoutConstraint!
    
    @IBOutlet var loginButtonHeight: NSLayoutConstraint!
    
    @IBOutlet var forgotbuttonHeight: NSLayoutConstraint!
    
    @IBOutlet var forgotButtonWidth: NSLayoutConstraint!
    
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var cancelButtonWidth: NSLayoutConstraint!
    @IBOutlet var cancelButtonHeight: NSLayoutConstraint!
    
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //observers for hiding and showing keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow1:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide1:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard1")
        view.addGestureRecognizer(tap)
        
        self.password.delegate = self
        self.email.delegate = self

        
        self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        blurredViewHeight.constant = 0.6 * screenHeight
        blurredViewWidth.constant = 0.8 * screenWidth
        
        topToBlurredView.constant = 0.2 * screenHeight
        
        topToLoginLabel.constant = 0.1 * blurredViewHeight.constant
        loginLabelToEmail.constant =  0.1 * blurredViewHeight.constant
        emailToPassword.constant = 0.05 * blurredViewHeight.constant
        passwordToLoginButton.constant = 0.1 * blurredViewHeight.constant
        loginButtonToForgot.constant = 0.05 * blurredViewHeight.constant
        
        textFieldHeight.constant = 0.09 * blurredViewHeight.constant
        textFieldWidth.constant =  0.9 * blurredViewWidth.constant
        
        loginLabelHeight.constant = 0.1 * blurredViewHeight.constant
        loginButtonWidth.constant = 0.3 * blurredViewWidth.constant
        loginLabelHeight.constant = 0.1 * blurredViewHeight.constant
        
        forgotbuttonHeight.constant = 0.1 * blurredViewHeight.constant
        forgotButtonWidth.constant = 0.4 * blurredViewWidth.constant
        
        cancelButtonHeight.constant = 0.05 * screenHeight
        cancelButtonWidth.constant = cancelButtonHeight.constant
        
        email.layer.masksToBounds = true
        email.layer.cornerRadius = 20.0
        
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 20.0
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 6.0
        
        let frame = CGRectMake(0,0, textFieldHeight.constant * 0.9 ,  textFieldHeight.constant * 0.9)
        let passwordIcon = UIImageView(image : UIImage(named : "pass.png"))
        passwordIcon.contentMode = UIViewContentMode.ScaleToFill
        
        let leftView2 = UIView()
        leftView2.addSubview(passwordIcon)
        
        leftView2.frame = CGRectMake(0, 0, textFieldWidth.constant * 0.18, textFieldHeight.constant * 0.9)
        
        passwordIcon.frame = frame
        passwordIcon.center = leftView2.center
        
        self.password.leftView = leftView2
        self.password.leftViewMode = UITextFieldViewMode.Always
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName : UIColor.blackColor()])
        password.secureTextEntry = true
        

        
        let emailIcon = UIImageView(image : UIImage(named : "mail.png"))
        emailIcon.contentMode = UIViewContentMode.ScaleToFill
        
        let leftView3 = UIView()
        leftView3.addSubview(emailIcon)
        
        leftView3.frame = CGRectMake(0, 0, textFieldWidth.constant * 0.18, textFieldHeight.constant * 0.9)
        
        emailIcon.frame = frame
        emailIcon.center = leftView3.center
        
        self.email.leftView = leftView3
        self.email.leftViewMode = UITextFieldViewMode.Always
        email.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName : UIColor.blackColor()])
        
        
        
        
        
        
        
    }
    func keyboardWillShow1(notification: NSNotification) {
        
        print("keyboard will show 1")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.flag == 0 {
                topToBlurredView.constant -= keyboardSize.height/2.5
                self.flag = 1
                UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
        
    }
    
    func keyboardWillHide1(notification: NSNotification) {
        
        print("keyboard will hide 1")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.flag == 1 {
                topToBlurredView.constant += keyboardSize.height/2.5
                self.flag = 0
                UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
    }
    func dismissKeyboard1() {
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

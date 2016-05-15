//
//  SignUpViewController.swift
//  walk-in
//
//  Created by Bandi Anirudh on 14/05/16.
//  Copyright © 2016 Xlabs. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController , UITextFieldDelegate {

    
    
    @IBOutlet var signUp: UIButton!
    @IBOutlet var blurredView: UIView!
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    @IBAction func signUp(sender: AnyObject) {
        let username = self.username.text
        let password = self.password.text
        let email = self.email.text
        
        if username != "" && email != "" && password != "" {
            
            // Set Email and Password for the New User.
            
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    // There was a problem.
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    print(error.description)
                    
                } else {
                    
                    // Create and Login the New User with authUser
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        
                        let user = ["provider": authData.provider!, "username": username! ]
                        
                        // Seal the deal in DataService.swift.
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    
                    // Store the uid for future access - handy!
                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                    
                    // Enter the app.
                    print("success")
                   
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your password, and a username.")
        }

    }
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    @IBOutlet var viewWidth: NSLayoutConstraint!
    
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet var regToWelcome: NSLayoutConstraint!
    @IBOutlet var welcomeToNext: NSLayoutConstraint!
    @IBOutlet var usernameToAboveLabel: NSLayoutConstraint!
    @IBOutlet var usernameToEmail: NSLayoutConstraint!
    @IBOutlet var passwordToSignUp: NSLayoutConstraint!
    @IBOutlet var emailToPassword: NSLayoutConstraint!
    
    
    @IBOutlet var topToViewTop: NSLayoutConstraint!
    
    
    @IBOutlet var regLabelHeight: NSLayoutConstraint!
    @IBOutlet var welcomeLabelHeight: NSLayoutConstraint!
    @IBOutlet var weLabelHeight: NSLayoutConstraint!
    @IBOutlet var passwordTextFieldHeight: NSLayoutConstraint!
    @IBOutlet var signUpButtonHeight: NSLayoutConstraint!
    @IBOutlet var signUpButtonWidth: NSLayoutConstraint!
    @IBOutlet var usernameTextFieldWidth: NSLayoutConstraint!
    
    
    @IBOutlet var closeButtonWidth: NSLayoutConstraint!
    
    @IBOutlet var closeButtonHeight: NSLayoutConstraint!
    
    
    
    
    
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        //observers for hiding and showing keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.username.delegate = self
        self.password.delegate = self
        self.email.delegate = self
        
        //making the view's background blurred
        self.blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        //setting up constraints
        closeButtonHeight.constant = screenHeight * 0.05
        closeButtonWidth.constant = closeButtonHeight.constant
        
        viewWidth.constant = 0.8 * screenWidth
        viewHeight.constant = 0.7 * screenHeight
        
        regToWelcome.constant = viewHeight.constant * 0.007
        welcomeToNext.constant = viewHeight.constant * 0.007
        usernameToAboveLabel.constant = viewHeight.constant * 0.05
        usernameToEmail.constant = viewHeight.constant * 0.05
        emailToPassword.constant = viewHeight.constant * 0.05
        passwordToSignUp.constant = viewHeight.constant * 0.06
        
        topToViewTop.constant = 0.15 * screenHeight
        
        regLabelHeight.constant = viewHeight.constant * 0.1
        welcomeLabelHeight.constant = viewHeight.constant * 0.1
        weLabelHeight.constant = viewHeight.constant * 0.1
        passwordTextFieldHeight.constant = viewHeight.constant * 0.08
        signUpButtonHeight.constant = viewHeight.constant * 0.08
        signUpButtonWidth.constant = viewWidth.constant * 0.25
        usernameTextFieldWidth.constant = 0.95 * viewWidth.constant
        
        //giving the buttons rounded edges
        username.layer.masksToBounds = true
        username.layer.cornerRadius = 20.0
        
        password.layer.masksToBounds = true
        password.layer.cornerRadius = 20.0
        
        email.layer.masksToBounds = true
        email.layer.cornerRadius = 20.0
        
        
        //adding icons to textfields
        
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
        
        //changing placeholder text color
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
        
        
        let emailIcon = UIImageView(image : UIImage(named : "mail.png"))
        emailIcon.contentMode = UIViewContentMode.ScaleToFill
        
        let leftView3 = UIView()
        leftView3.addSubview(emailIcon)
        
        leftView3.frame = CGRectMake(0, 0, usernameTextFieldWidth.constant * 0.18, passwordTextFieldHeight.constant * 0.9)
        
        emailIcon.frame = frame
        emailIcon.center = leftView3.center
        
        self.email.leftView = leftView3
        self.email.leftViewMode = UITextFieldViewMode.Always
        email.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName : UIColor.blackColor()])
        
        
        //rounding sign up button
        signUp.layer.masksToBounds = true
        signUp.layer.cornerRadius = 6.0
        
        
    }
    func keyboardWillShow(notification: NSNotification) {
        print("keyboard will show")
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
        print("keyboard will hide")
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

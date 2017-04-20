//
//  CreateAccountViewController.swift
//  
//
//  Created by Craig Martin on 4/28/15.
//
//

import UIKit

protocol CreateAccountViewControllerDelegate {
    func accountCreated()
}

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var chooseUsernameTextBox: UITextField!
    
    @IBOutlet weak var choosePasswordTextBox: UITextField!
    
    @IBOutlet weak var confirmPasswordTextBox: UITextField!
    
    let kUsernameKey = "usernameKey"
    let kPasswordKey = "passwordKey"
    
    var delegate:CreateAccountViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Functions

    @IBAction func createButtonPressed(sender: AnyObject) {
        
        if choosePasswordTextBox.text != "" && choosePasswordTextBox.text == confirmPasswordTextBox.text && chooseUsernameTextBox.text != "" {
            println("Password: \(choosePasswordTextBox.text)")
            NSUserDefaults.standardUserDefaults().setObject(chooseUsernameTextBox.text, forKey: kUsernameKey)
            NSUserDefaults.standardUserDefaults().setObject(choosePasswordTextBox.text, forKey: kPasswordKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
            delegate?.accountCreated()
            
        } else if chooseUsernameTextBox.text == "" {
            usernameAlertView()
        } else if choosePasswordTextBox != "" && choosePasswordTextBox.text != confirmPasswordTextBox.text {
            passwordDoesNotMatchAlertView()
            choosePasswordTextBox.text = ""
            confirmPasswordTextBox.text = ""
        } else if choosePasswordTextBox.text == "" || confirmPasswordTextBox.text == "" {
            enterPasswordAlertView()
        } else {
            println("Something Went Wrong")
        }

    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Helper Functions
    
    func enterPasswordAlertView() {
        var alert = UIAlertController(title: "No Password Entered", message: "Please enter a password", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func passwordDoesNotMatchAlertView() {
        var alert = UIAlertController(title: "Passwords Do Not Match", message: "Please Retry", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func usernameAlertView() {
        var alert = UIAlertController(title: "No Username Entered", message: "Please Enter a Username", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

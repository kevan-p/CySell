//
//  CreateAccountViewController.swift
//  LoginScreen
//
//  Created by Matthew Smith on 9/12/18.
//  Copyright © 2018 Matthew Smith. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userFullNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordRepeatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        
        let userFullName = userFullNameTextField.text;
        let userEmail = userEmailTextField.text;
        let userName = userNameTextField.text;
        let userPassword = userPasswordTextField.text;
        let userPasswordRepeat = userPasswordRepeatTextField.text;
        
        if((userFullName?.isEmpty)! || (userEmail?.isEmpty)! || (userName?.isEmpty)! || (userName?.isEmpty)! || (userPassword?.isEmpty)! || (userPasswordRepeat?.isEmpty)!){
            //Display alert message
            displayMyAlertMessage(userMessage: "Fill in empty fields!");
            return;
        }
        if(userPassword != userPasswordRepeat){
            displayMyAlertMessage(userMessage: "Passwords do not match");
        }
        
    }
    
    func displayMyAlertMessage(userMessage: String){
        var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle:UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
        
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  EditProfileView.swift
//  Frontend
//
//  Created by Kevan Patel on 11/3/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import Alamofire

/// This is a class view that allows the user to
/// edit their profile the way they see fit.
/// They are able to add any extra information that they desire
/// like email and phone number. 
class EditProfileView: UIViewController {
    
    ///Outlet for classificiation UI text field
    @IBOutlet weak var classificationText: UITextField!
    ///Outlet for major UI text field
    @IBOutlet weak var majorText: UITextField!
    ///Outlet for phone number UI text field
    @IBOutlet weak var phoneText: UITextField!
    ///Outlet for description UI text field
    @IBOutlet weak var descriptionText: UITextField!
    
    /// Variable for user entered classification
    var classification = ""
    /// Variable for user entered major
    var major          = ""
    /// Variable for user entered phone number
    var phone          = ""
    /// Variable for user entered description
    var descriptions   = ""
    
    ///checks if view loads with no errors
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    ///edits information and performs segue to ProfileView
    func editInformation() {
        self.classification = classificationText.text!
        self.major          = majorText.text!
        self.phone          = phoneText.text!
        self.descriptions   = descriptionText.text!
        
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    ///saves editted information into database
    func saveInformationDB() {
            // default table for posting is furniture because it's the first value in picker.
            let classification: String = classificationText.text!
            let major: String          = majorText.text!
            let phone: String          = phoneText.text!
            let descriptions           = descriptionText.text!
            
            let parameters: [String: Any] = [
                "name": classification,
                "major": major,
                "phone": phone,
                "description": descriptions
            ]
        
            Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response)
            }
    }
    
    ///stores EditProfileView variables into ProfileView variables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var viewControl = segue.destination as! ProfileView
        viewControl.finalClassification = self.classification
        viewControl.finalMajor          = self.major
        viewControl.finalPhone          = self.phone
        viewControl.finalDescription    = self.descriptions
    }
    
    /// Cancels current edit and returns to previous profile screen
    ///
    /// - Parameter sender: waits for cancel button to be pressed
    @IBAction func doneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Saves current entered in information and sends to profile screen
    ///
    /// - Parameter sender: waits for save button to be pressed
    @IBAction func saveButton(_ sender: UIButton) {
        editInformation()
        saveInformationDB()
    }
}

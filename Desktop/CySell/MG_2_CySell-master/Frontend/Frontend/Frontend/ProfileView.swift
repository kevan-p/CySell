//
//  ProfileView.swift
//  Frontend
//
//  Created by Kevan Patel on 11/1/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Alamofire


/// This class view allows the user to look at their profile.
/// If they so desire, they can click on the button to edit their profile
/// and change what they want. The Profile view simply allows them to look
/// at their information whenever they want. 
class ProfileView: UIViewController {
    
    /// Outlet for profileID as UI label
    @IBOutlet weak var ProfileID: UILabel!
    /// Outlet for profile picture as UI image view
    @IBOutlet weak var profilePicture: UIImageView!
    /// Outlet for first name as UI label
    @IBOutlet weak var profileFirstName: UILabel!
    /// Outlet for last name as UI label
    @IBOutlet weak var profileLastName: UILabel!
    /// Outlet for email as UI label
    @IBOutlet weak var profileEmail: UILabel!
    
    /// Outlet for classification as UI label
    @IBOutlet weak var profileClassification: UILabel!
    /// Outlet for major as UI label
    @IBOutlet weak var profileMajor: UILabel!
    /// Outlet for phone number as UI label
    @IBOutlet weak var profilePhone: UILabel!
    /// Outlet for descriptoin as UI label
    @IBOutlet weak var profileDescription: UILabel!
    /// Outlet for edit profile button as UI button
    @IBOutlet weak var editButton: UIButton!
    
    /// Classification String filled my EditProfileView segue
    var finalClassification = ""
    /// Major String filled my EditProfileView segue
    var finalMajor          = ""
    /// Phone Number String filled my EditProfileView segue
    var finalPhone          = ""
    /// Description String filled my EditProfileView segue
    var finalDescription    = ""
    
    ///Checks if view loads and sets EditProfileView information into ProfileView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileClassification.text = finalClassification
        profileMajor.text          = finalMajor
        profilePhone.text          = finalPhone
        profileDescription.text    = finalDescription
        
        profileFirstName.text = ""
        profileLastName.text  = ""
        ProfileID.text        = ""
        
        if let _ = FBSDKAccessToken.current() {
            profileFetch()
        }
    }
    
    /// Gets user information of current user that is logged in
    func profileFetch() {
         print("fetch profile")
        
        let parameters = ["fields": "email, id, first_name, last_name, picture.width(480).height(480)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters)?.start(completionHandler: { (connection, result, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            else {
                guard let data = result as? [String:Any] else { return }
                
                let facebookFirst = data["first_name"]
                let facebookLast  = data["last_name"]
                let facebookID    = data["id"]
                let facebookID_int = data["id"]
                
                self.profileFirstName.text = facebookFirst as! String
                self.profileLastName.text  = facebookLast as! String
                self.ProfileID.text        = facebookID as! String
            }
            
            print(result ?? "result")
        })
    }
    
    /// Stores profile into database with parameters
    ///
    /// - Parameter sender: waits for button to be pressed to perform action
    @IBAction func storeProfile(_ sender: UIButton) {
        let firstName: String      = profileFirstName.text!
        let lastName: String       = profileLastName.text!
        let classification: String = profileClassification.text!
        let major: String          = profileMajor.text!
        let phone: String          = profilePhone.text!
        let description: String    = profileDescription.text!
        let parameters: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "classification": classification,
            "major": major,
            "phone": phone,
            "description": description
        ]
        
        //http://proj309-mg-02.misc.iastate.edu:8080/profile
        //http://localhost:8080/profile
        Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                print(response)
        }
    }
}

//
//  LoginViewController.swift
//  Frontend
//
//  Created by Matthew Smith on 10/29/18.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Alamofire



struct User {
    var name : String?
    var id : Int?
    
    init(name: String?,id: Int?) {
        self.name = name
        self.id = id
    }
}

/// This class is for the LoginViewController. This establishes code
/// for a user being able to login to the application.
class LoginViewController: UIViewController {
    
    /// A variable to put dictionary values into.
    var dict : [String : AnyObject]!
    
    /// A varabiel of that stores the type User.
    var users = [User]()
    
    
  
    
    /// When the Login button is clicked, Facebook goes through it's authorization.
    /// If the case is failed, then it prints an error, if the user cancels their login,
    /// then a message prints "User cancelled login." If the login is a sucess, it grabs
    /// the User data from facebook and posts it in the database. Then it transitions into the main
    /// page of the app.
    ///
    /// - Parameter sender: Any: Reacts when the user clicks the Login With Facebook Button
    @IBAction func LoginButtonClicked(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
                self.transition()
            }
        }
    }
    
    /// A struct for a User with a unique ID and Name.

    /// A method for transitioning onto the next view controller.
    func transition() {
        let next:ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    /// This method loads LoginViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// This method grabs the FB User data using FBSDK. In this case it grabs the unique
    /// ID and name for each user. It grabs that data, establishes it in parameters, and posts
    /// it into the database. If a User already has an account, it makes sure not to post it more
    /// than once.
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String: AnyObject]
                    print(result!)
                    //print(self.dict)
                    let FBname: String? = self.dict["name"] as? String
                    let FBId: Int? = self.dict["id"] as? Int
                    let parameters: [String: Any] = [
                        "fullName": FBname!
                        ]
                    
//                    Alamofire.request("http://localhost:8080/users",method : .get).responseJSON { response in
//                        if let json = response.result.value {
//                            let userArray : NSArray = json as! NSArray
//                            for i in 0..<userArray.count{
//                                self.users.append(User(
//                                    fullName: (userArray[i] as AnyObject).value(forKey: "fullName") as? String,
//                                ))
//                                if(userArray[i] as? String == FBname!){
                    Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/user" , method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                        .responseString { response in
                                            print(response)
                                    }
                                //}
                            //}
                        //}
                    //}
                }
            })
        }
    }
}

//
//  CreateAccountViewController.swift
//  Frontend
//
//  Created by Mitchell Knoth on 10/21/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import Alamofire
import item

class CreateAccountViewController: UIViewController {

    
    
    
    struct User {
        var fullName : String?
        var username : String?
        var email : String?
        var password: String?
        
        
        init(fullName: String?,username: String?, email: String?, password: String? ) {
            self.fullName = fullName
            self.username = username
            self.email = email
            self.password = password
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //http://proj309-mg-02.misc.iastate.edu:8080/item
        Alamofire.request("http://localhost:8080/login/{User}",method : .post).responseJSON {
                self.table.reloadData()
            }
            
        }
        //self.table.reloadData()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

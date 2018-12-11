//
//  ShowMore_ViewController.swift
//  Frontend
//
//  Created by abdelrahman shamarden on 10/15/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import Alamofire

/// a ViewController that is used to display more information about the chosen item and its seller
var seller_id_SM : String? = ""

class ShowMore_ViewController: UIViewController {
    
        var item : Item?
    
    var save_seller : String?
    /// To access the Seller's ID
    @IBOutlet weak var Seller_ID: UILabel!
    ///To access the item's images
    @IBOutlet weak var Item_Images: UIImageView!
    /// To access the item's name
    @IBOutlet weak var Item_Name: UILabel!
    /// To access theitem's price
    @IBOutlet weak var Item_Price: UILabel!
    /// To access the item's describtion
    @IBOutlet weak var Item_Desc: UILabel!
    /// To access the seller's name
    @IBOutlet weak var Seller_Name: UILabel!
    /// A button to show the Chat view
    ///
    /// - Parameter sender: a parameter of type any
    @IBAction func Message_Seller(_ sender: Any) {
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Item_Name?.text =  "Item's Name: \(n!)"
        Item_Price?.text = "Item's Price:$ \(p!)"
        Item_Desc?.text =  "Item's Describtion: \(d!)"
        Seller_Name?.text = "Seller's Name: \(name_s!)"
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


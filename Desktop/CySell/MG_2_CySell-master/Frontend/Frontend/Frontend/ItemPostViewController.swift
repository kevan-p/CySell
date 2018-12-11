//
//  ItemPostViewController.swift
//  Frontend
//
//  Created by Matthew Smith on 10/8/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import Alamofire

//var seller_name : String? = ""
//var seller_id : String? = ""

/// This is the ItemPostViewController. This a view that allows a User to post a unique item. Once
/// they post this item, it is stored into the database and saved under it's category, name, price,
/// and description.
class ItemPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    
    /// The text field for the name of the item that is posted.
    @IBOutlet weak var itemName: UITextField!
    
    /// The text field for the price that of the item that is posted.
    @IBOutlet weak var itemPrice: UITextField!
    
    /// The text field for the description of the item that is posted.
    @IBOutlet weak var itemDesc: UITextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    /// The text field for the image of the item that is posted.
    @IBOutlet weak var UploadedImg: UIImageView!
    
    /// The category picker that allows the User to select the type.
    @IBOutlet weak var CategoryPicker: UIPickerView!
    
    /// A variable to establish the type in the later if statements.
    var type:String = ""
    
    /// An array that has the types of categories the user can choose from. 
    var categories = ["Furniture","Tickets","Books","Electronics"]
    
    var finalAddress = ""
    /// Allows an image of the user's choice to upload.
    /// This image will present itself when posting an item
    /// so other user's know what the items look like.
    ///
    /// - Parameter sender: AnyObject: Senses when somone clicks on the "Upload Picture" button.
    @IBAction func UploadPic(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated:true){
            
        }
    }

    /// This is a PickerController that allows the user to choose pictures. When
    /// they choose a picture, it will display.
    ///
    /// - Parameters:
    ///   - picker: UIImagePickerController: This is the controller that allows the user to choose.
    ///   - info: UIImagePickerController.InfoKey.originalImage: This is the image's information.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[ UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            UploadedImg.image = image
        }
        else {
            // error
        }
        self.dismiss(animated: true, completion: nil)
    }

    /// This method loads the ItemPostViewController, as well as the CategoryPicker.
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryPicker.delegate = self
        CategoryPicker.dataSource = self
        
        addressLabel.text = finalAddress
        
        //seller_id = profileID
        //seller_name = firstName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Establishes the number of components in the PickerView.
    ///
    /// - Parameter in: UIPickerView: The picker that allows Users to select from 4 categories.
    /// - Returns: 1
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    /// This returns the category count.
    ///
    /// - Parameters:
    ///   - pickerView: UIPickerView: The picker that allows Users to select from 4 categories.
    ///   - component: Int
    /// - Returns: categories.count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    /// Returns the category in a specific row.
    ///
    /// - Parameters:
    ///   - pickerView: UIPickerView: The picker that allows Users to select from 4 categories.
    ///   - row: Number of rows in the category.
    ///   - component: Int
    /// - Returns: categories[row]
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    /// Establishes which type the user wants to pick in the UIPicker. A series of if statements
    /// that makes sure the user is picking the right one.
    ///
    /// - Parameters:
    ///   - pickerView: UIPickerView: The View that allows users to pick from a series of types.
    ///   - row: Int: Establishes the row of the category that the User picks.
    ///   - component: Int
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  categories[row] == "Furniture"{
            // set posting table to furniture
            print("furn works")
            type = "Furniture"
        }
        else if categories[row] == "Tickets"{
            // set table to tickets
            print( "tick works")
            type = "Tickets"
        }
        else if categories[row] == "Electronics"{
            // set table to electronics
            print("elec works")
            type = "Electronics"
        }
        else {
             // set posting table to books
            print("books work")
            type = "Books"
        }
    }
    
    /// This is the method that reacts when the post button is tapped.
    /// When it is tapped it uses the user's input and posts that information in
    /// the database. Each item has its own name, price, type, and description.
    ///
    /// - Parameter sender: Any: Reacts when the User clicks on the Post Item button.
    @IBAction func onPostTapped(_ sender: Any) {
        
        let user_ID = profileID
        let seller_name : String = firstName!
        let name: String = itemName.text!
        let price: String = itemPrice.text!
        //let img: UIImage = UploadedImg.image!
        let description: String = itemDesc.text!
        let itemType: String = type
        let parameters: [String: Any] = [
            "seller_name" : seller_name ,
            "name": name,
            "price": price,
            "description": description,
            "type": itemType,
            "postedByUserId": user_ID
        ]
//http://proj309-mg-02.misc.iastate.edu:8080/item
        //http://localhost:8080/item
        let user : String = user_ID!
        id_i = user
        //name_s =
        print(user)
        Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/\(user)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                print(response)
                self.transition()
                //id = user_ID
                //name_s = seller_name
                //print(id)
        }
    }
    
    /// A method that transitions into the next ViewController given.
    func transition() {
        let next: ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    }
    



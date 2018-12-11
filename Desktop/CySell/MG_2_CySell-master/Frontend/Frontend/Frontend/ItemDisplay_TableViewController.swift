//
//  ItemDisplay_TableViewController.swift
//  Frontend
//
//  Created by abdelrahman shamarden on 10/5/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import Alamofire


var n : String? = ""
var p : String? = ""
var d : String? = ""
var a : String? = ""
var id_i : String? = ""
var name_s : String? = ""

/// A struct for a unique item. An item has a name, id, description, type, and price
struct Item {
    var name : String?
    var id : String?
    var description: String?
    //var address: String?
    var type: String?
    var price : String?
    var postedByUserID : String?
    var seller_name_ : String?
    //var img: UIImage?
    
    init(name: String?,id: String?, description: String?, type: String?, price: String?, postedByUserID: String? , seller_name_ : String?) {
        self.name = name
        self.id = id
        self.description = description
        //self.address = address
        self.type = type
        self.price = price
        self.postedByUserID = postedByUserID
        self.seller_name_ = seller_name_
        //self.img = img
    }

}



/// This is a view controller that shows a list of items that were posted by various users.
/// Each item is represented by a cell, and each cell is in a table. Each table view loads different
/// information depending on which category the user picks that they want to browse.
class ItemDisplay_TableViewController: UITableViewController {
    
    /// The tableview for Books.
    @IBOutlet weak var BooksTable: UITableView!
    
    /// The tableview for Electronics.
    @IBOutlet weak var ElectronicsTable: UITableView!
    
    /// The tableview for Furniture.
    @IBOutlet weak var FurnitureTable: UITableView!
    
    /// The tableview for Tickets.
    @IBOutlet weak var TicketsTable: UITableView!
    
    /// An array of items that are of type Item.
    var items = [Item]()
    
    /// The tableURL so it can establish which type goes in each tableview.
    var tableUrl : String?
    
    /// The table, value changes depending on the category. 
    var table : UITableView!
    

    
    
    /// This method loads the table view controller for the User. This is where the user can
    /// look at items, see what their name, price, type and description is. They load from
    /// an Alamofire request that takes the json from the database and posts that into the UI.
    /// It does that by parsing through and finding the type of item. If the user clicks on a certain
    /// type, then it loads that particular data for that item.
    override func viewDidLoad() {
        super.viewDidLoad()
        /////
        if ElectronicsTable?.dataSource != nil {
            print (" electronics works")
            tableUrl = "electronics"
            table = ElectronicsTable
            table.estimatedRowHeight = 85.0
            table.rowHeight = UITableView.automaticDimension
            Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/elec",method : .get).responseJSON { response in
                if let json = response.result.value {
                    let elecArray : NSArray = json as! NSArray
                    for i in 0..<elecArray.count{
                        self.items.append(Item(name: (elecArray[i] as AnyObject).value(forKey: "name") as? String,
                                               id: (elecArray[i] as AnyObject).value(forKey: "id") as? String,
                                               description: (elecArray[i]  as AnyObject).value(forKey: "description") as? String,
                                               type: (elecArray[i]  as AnyObject).value(forKey: "type") as? String,
                                               price:  (elecArray[i]  as AnyObject).value(forKey: "price") as? String,
                                               postedByUserID: (elecArray[i] as AnyObject).value(forKey: "postedByUserID") as? String,

                                               seller_name_: (elecArray[i] as AnyObject).value(forKey: "seller_name") as? String
                            //img: (elecArray[i]  as AnyObject).value(forKey: "image") as? UIImage
                        ))                    }
                    self.table.reloadData()
                }
            }
            
        }
        else if BooksTable?.dataSource != nil{
            print (" books works")
            tableUrl = "books"
            table = BooksTable
            table.estimatedRowHeight = 85.0
            table.rowHeight = UITableView.automaticDimension
            Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/book",method : .get).responseJSON { response in
                if let json = response.result.value {
                    let bookArray : NSArray = json as! NSArray
                    for i in 0..<bookArray.count{
                        self.items.append(Item(name: (bookArray[i] as AnyObject).value(forKey: "name") as? String,
                                               id: (bookArray[i] as AnyObject).value(forKey: "id") as? String,
                                               description: (bookArray[i]  as AnyObject).value(forKey: "description") as? String,
                                               type: (bookArray[i]  as AnyObject).value(forKey: "type") as? String,
                                               price:  (bookArray[i]  as AnyObject).value(forKey: "price") as? String,
                                               postedByUserID: (bookArray[i] as AnyObject).value(forKey: "postedByUserID") as? String,
                                               seller_name_: (bookArray[i] as AnyObject).value(forKey: "seller_name") as? String
                        ))
                    }
                    self.table.reloadData()
                }
            }
        }
        else if TicketsTable?.dataSource != nil {
            print (" tickets works")
            tableUrl = "tickets"
            table = TicketsTable
            table.estimatedRowHeight = 85.0
            table.rowHeight = UITableView.automaticDimension
            Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/ticket",method : .get).responseJSON { response in
                if let json = response.result.value {
                    let ticketArray : NSArray = json as! NSArray
                    for i in 0..<ticketArray.count{
                        self.items.append(Item(name: (ticketArray[i] as AnyObject).value(forKey: "name") as? String,
                                               id: (ticketArray[i] as AnyObject).value(forKey: "id") as? String,
                                               description: (ticketArray[i]  as AnyObject).value(forKey: "description") as? String,
                                               type: (ticketArray[i]  as AnyObject).value(forKey: "type") as? String,
                                               price:  (ticketArray[i]  as AnyObject).value(forKey: "price") as? String,
                                               postedByUserID: (ticketArray[i] as AnyObject).value(forKey: "postedByUserID") as? String,
                                               seller_name_: (ticketArray[i] as AnyObject).value(forKey: "seller_name") as? String
                        ))
                    }
                    self.table.reloadData()
                }
            }
        }
        else {
            
            print (" furniture works")
            tableUrl = "furniture"
            table = FurnitureTable
            table.estimatedRowHeight = 85.0
            table.rowHeight = UITableView.automaticDimension
            Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/furn",method : .get).responseJSON { response in
                if let json = response.result.value {
                    let furnArray : NSArray = json as! NSArray
                    for i in 0..<furnArray.count{
                        self.items.append(Item(name: (furnArray[i] as AnyObject).value(forKey: "name") as? String,
                                               id: (furnArray[i] as AnyObject).value(forKey: "id") as? String,
                                               description: (furnArray[i]  as AnyObject).value(forKey: "description") as? String,
                                               type: (furnArray[i]  as AnyObject).value(forKey: "type") as? String,
                                               price:  (furnArray[i]  as AnyObject).value(forKey: "price") as? String,
                                               postedByUserID: (furnArray[i] as AnyObject).value(forKey: "postedByUserID") as? String,
                                               seller_name_: (furnArray[i] as AnyObject).value(forKey: "seller_name") as? String
                    ))
                        
                    }
                    self.table.reloadData()
                }
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    /// This is a method that posts the cells of the table into the UI. Each cell represents an item
    /// that was posted.
    ///
    /// - Parameters:
    ///   - tableView: UITableView: A view for the User to view tables with Items on them.
    ///   - indexPath: IndexPath
    /// - Returns: cell: The cell for that specific Item.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemPost", for: indexPath) as! ItemPost_TableViewCell
        let item: Item
        item = items[indexPath.row]
        print(item)
        cell.ItemPrice.text = item.price
        cell.ItemName.text = item.name
        n = item.name
        p = item.price
        d = item.description
        id_i = item.postedByUserID!
        name_s = item.seller_name_!
        //cell.ItemImage.image = item.img
        
        Alamofire.request("http://proj309-mg-02.misc.iastate.edu:8080/item/user/\(item)",method : .get).responseJSON { response in
            if let json = response.result.value {
                print(json)
                
            }
            
        }
        
        return cell
    }
}


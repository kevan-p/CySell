//
//  FurnitureTableViewController.swift
//  MainPage
//
//  Created by abdelrahman shamarden on 9/12/18.
//  Copyright © 2018 abdelrahman shamarden. All rights reserved.
//

import UIKit
import Foundation

class FurnitureTableViewController: UITableViewController {
    var dicFurniture = [String : String]()
    var Furniture_array = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fileURL = Bundle.main.path(forResource: "myfile", ofType: "txt")
        do {
            let fulltext = try String(contentsOfFile: fileURL!, encoding:String.Encoding.utf8)
            var  readings = fulltext.components(separatedBy: "\n") as [String]
            for i in 0 ..< readings.count{
                //
                let postData = readings[i].components(separatedBy: ", ")
                dicFurniture["Post_Name"] = "\(postData[0])"
                dicFurniture["seller_Name"] = "\(postData[1])"
                dicFurniture["Desc"] = "\(postData[2])"
                dicFurniture["Price"] = "\(postData[3])"
                //readings[i+1] = readings[i+1].trimmingCharacters(in:.whitespacesAndNewlines)
                Furniture_array.add(dicFurniture)
                //i = i+1
          }
        } catch let error as NSError{
            print("Error:\(error)")
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Furniture_array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let post =  Furniture_array[indexPath.row] as AnyObject
        cell.textLabel?.text =  "\(post.object(forKey: "Post_Name")!)  \(post.object(forKey: "Price")!)"
        cell.textLabel?.text =  "\(post.object(forKey: "Desc")!)  \(post.object(forKey: "Seller_Name")!)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

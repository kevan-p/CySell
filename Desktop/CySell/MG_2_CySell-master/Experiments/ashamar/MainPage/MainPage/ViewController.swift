//
//  ViewController.swift
//  MainPage
//
//  Created by abdelrahman shamarden on 9/7/18.
//  Copyright © 2018 abdelrahman shamarden. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func FurnitureClick(_ sender: UIButton) {
        //self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
        //self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
//        let fileURL = Bundle.main.path(forResource: "myfile", ofType: "txt")
//        var readString = ""
//        do {
//            readString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
//        } catch let error as NSError {
//            print("Failed to read from file")
//            print(error)
//        }
//        print (readString)
        
    }
    
    @IBAction func TicketClick(_ sender: UIButton) {
    }
    
    @IBAction func ElectronicsClick(_ sender: UIButton) {
    }
    
    @IBAction func BooksClick(_ sender: UIButton) {
    }
}


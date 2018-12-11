//
//  ItemPost_TableViewCell.swift
//  Frontend
//
//  Created by abdelrahman shamarden on 10/5/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit


/// A cell to display an Item that is being sold
class ItemPost_TableViewCell: UITableViewCell {
    let SM = ShowMore_ViewController()
    /// To access Item's price
    @IBOutlet weak var ItemPrice: UILabel!
    /// To access Item's Name
    @IBOutlet weak var ItemName: UILabel!
    /// To access Item's Image
    @IBOutlet weak var ItemImage: UIImageView!
    /// A button to display the showmore_ViewController
    @IBAction func ShowMore(_ sender: UIButton) {
        
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

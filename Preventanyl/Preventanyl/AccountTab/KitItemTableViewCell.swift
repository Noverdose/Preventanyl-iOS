//
//  KitItemTableViewCell.swift
//  Preventanyl
//
//  Created by Yu Hong Huang on 2017-11-25.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class KitItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var label: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

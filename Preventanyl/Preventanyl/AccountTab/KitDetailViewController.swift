//
//  KitDetailViewController.swift
//  Preventanyl
//
//  Created by kenth on 2017-11-26.
//  Copyright © 2017 Yudhvir Raj. All rights reserved.
//

import UIKit

class KitDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = kit.displayName
        phonenumLabel.text = kit.phone
        cityLabel.text = kit.address.city
        countryLabel.text = kit.address.country
        PostCodeLabel.text = kit.address.postalCode
        provinceLabel.text = kit.address.provincestate
        streetLabel.text = kit.address.streetAddress
        commentLabel.text = kit.comments
        
    }
    
    var kit : StaticKit!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var PostCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phonenumLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

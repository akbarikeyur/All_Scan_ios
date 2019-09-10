//
//  CustomMyWorkTVC.swift
//  All Scan
//
//  Created by Keyur on 31/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class CustomMyWorkTVC: UITableViewCell {

    @IBOutlet weak var imgView: ImageView!
    @IBOutlet weak var contentTxtView: TextView!
    @IBOutlet weak var durationLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

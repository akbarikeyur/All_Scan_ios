//
//  SettingVC.swift
//  All Scan
//
//  Created by PC on 26/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: - Button click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToReset(_ sender: Any) {
        showAlertWithOption("Reset", message: "You will loss your all work, are you sure you want to reset app?", completionConfirm: {
            removeUserDefaultValues()
            AppModel.shared.MY_WORK = [WorkModel]()
        }) {
            
        }
    }
    
    @IBAction func clickToRateus(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

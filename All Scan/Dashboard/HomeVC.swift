//
//  HomeVC.swift
//  All Scan
//
//  Created by Hash on 07/01/19.
//  Copyright © 2019 Hash. All rights reserved.
//

import UIKit


class HomeVC: UIViewController {
    
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var myworkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDesignSetUp()
    }
    
    func appDesignSetUp() {
        startBtn.setBackgroundImage(imageFromColor(color: AppColor), for: .highlighted)
        startBtn.setTitleColor(WhiteColor, for: .highlighted)
        myworkBtn.setBackgroundImage(imageFromColor(color: AppColor), for: .highlighted)
        myworkBtn.setTitleColor(WhiteColor, for: .highlighted)
    }

    //MARK: - Button Click
    @IBAction func clickToStart(_ sender: Any) {
        let vc : StartVC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as! StartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToMyWork(_ sender: Any) {
        let vc : MyWorkVC = self.storyboard?.instantiateViewController(withIdentifier: "MyWorkVC") as! MyWorkVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToHelp(_ sender: Any) {
        let vc : AppGuidenanceVC = self.storyboard?.instantiateViewController(withIdentifier: "AppGuidenanceVC") as! AppGuidenanceVC
        self.navigationController?.present(vc, animated: true, completion: {
            
        })
    }
    
}


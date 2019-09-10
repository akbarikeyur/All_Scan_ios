//
//  WebViewVC.swift
//  All Scan
//
//  Created by Keyur on 31/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {

    @IBOutlet weak var appWebView: UIWebView!
    
    var webUrl : URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        appWebView.loadRequest(URLRequest(url: webUrl))
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

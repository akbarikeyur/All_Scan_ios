//
//  AppGuidenanceVC.swift
//  All Scan
//
//  Created by Keyur on 10/07/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class AppGuidenanceVC: UIViewController {

    @IBOutlet weak var guideTxtView: TextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let strGuide = "<!DOCTYPE html><html><body><font size=\"4\">All Scanner is a handy scanner app that will turn your iPhone device into a powerful mobile scanner. Easily scan, save and share any document in JPEG format.</br></br><b>QR Code</b></br></br><pre><u>Generate QR code</u></br>You can generate your own QR code. You have to just add your content like your Business name, link, contact information, etc.</br>By clicking on “Generate” button, QR code will generate and you can share or save it easily.</pre></br><pre><u>Scan QR code</u></br>You can scan any QR code and get content of QR code.</pre></br><b>Barcode</b></br></br><pre><u>Generate Barcode</u></br>You can generate your own Barcode. You have to just add your content like your Business name, link, contact information, etc.</br>By clicking on “Generate” button, Barcode will generate and you can share or save it easily.</pre></br><pre><u>Scan Barcode</u></br>You can scan any Barcode and get content of QR code.</pre></br><b>Document</b></br><pre>As we can see today is digital time, so we have to upload documents everywhere for identity proof as softcopy. All Scan will help you to scan your document easily and save or share to anywhere.</pre></br><b>Signature</b></br><pre>As we can see today is digital signature, so we have to submit digital signature in documents or many types of NDA. All Scan will help you to create your digital signature  and save or share to anywhere.</pre></br><b>My Work</b></br><pre>All scan always generate your work history so no need to repeat your work. It’s time saving. You can see your work history and easy to share your last QR code, barcode documents or signature.</pre></br><b>Settings</b></br><pre>By Reset app, you will lose your all work history.</pre></font></body></html>"

        let htmlData = NSString(string: strGuide).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        guideTxtView.attributedText = attributedString
        
        DispatchQueue.main.async {
            self.guideTxtView.setContentOffset(.zero, animated: true)
            self.guideTxtView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        }
        
    }
    
    
    
    @IBAction func clickToLetsstart(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
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

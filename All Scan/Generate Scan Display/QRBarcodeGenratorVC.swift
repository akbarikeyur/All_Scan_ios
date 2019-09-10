//
//  QRBarcodeGenratorVC.swift
//  All Scan
//
//  Created by PC on 26/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class QRBarcodeGenratorVC: UIViewController {

    @IBOutlet var titleTxt: Label!
    @IBOutlet weak var addTextView: PlaceholderTextView!
    @IBOutlet var generateBtn: UIButton!
    
    var type : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 0 {
            titleTxt.text = "Generate QR Code"
        }
        else if type == 1 {
            titleTxt.text = "Generate Barcode"
        }
        generateBtn.setBackgroundImage(imageFromColor(color: AppColor), for: .highlighted)
        generateBtn.setTitleColor(WhiteColor, for: .highlighted)
        
    }
    
    //Mark: - BUtton click
    @IBAction func clickToGenerteCode(_ sender: Any) {
        self.view.endEditing(true)
        if addTextView.text.trimmed == ""
        {
            displayToast("Please add text")
        }
        else
        {
            if type == 0
            {
                if let image : UIImage = generateQRcode(from: addTextView.text)
                {
                    let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
                    vc.type = type
                    vc.generatedImage = image
                    vc.content = addTextView.text
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else
            {
                if let image : UIImage = generateBarcode(from: addTextView.text)
                {
                    print(image.pngData()!)
                    print(image.jpegData(compressionQuality: 1.0)!)
                    let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
                    vc.type = type
                    vc.generatedImage = image
                    vc.content = addTextView.text
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }

}

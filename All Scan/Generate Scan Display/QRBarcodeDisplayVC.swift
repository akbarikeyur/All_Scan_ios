//
//  QRBarcodeDisplayVC.swift
//  All Scan
//
//  Created by Keyur on 29/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit
import SwiftOCR

class QRBarcodeDisplayVC: UIViewController {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var contentTxt: Label!
    @IBOutlet weak var imgView: UIImageView!
    
    var type : Int = 0
    var generatedImage : UIImage = UIImage.init()
    var content : String = ""
    let swiftOCRInstance = SwiftOCR()
    var isDisplay : Bool = false
    var newWork : WorkModel = WorkModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if newWork.uID == "" {
            isDisplay = false
            contentTxt.text = content
            imgView.image = generatedImage
            
            newWork.uID = getCurrentTimeStampValue()
            newWork.type = type
            storeImageInDocumentDirectory(image: imgView.image!, imageName: newWork.uID)
            newWork.image = newWork.uID
            newWork.content = content
            newWork.date = getCurrentTimeStampValue()
            saveMyWorkHistory(newWork: newWork)
        }
        else
        {
            isDisplay = true
            contentTxt.text = newWork.content
            if let image = getImage(imageName: newWork.image)
            {
                imgView.image = image
            }
        }
        if type == 0
        {
            titleLbl.text = "QR Code"
        }
        else if type == 1
        {
            titleLbl.text = "BarCode"
        }
        else if type == 2
        {
            titleLbl.text = "Document"
            scanDocument()
        }
        else if type == 3
        {
            titleLbl.text = "Signature"
        }
    }
    
    func scanDocument()
    {
        swiftOCRInstance.recognize(generatedImage) { recognizedString in
            print(recognizedString)
        }
    }
    
    @IBAction func clickToSave(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(generatedImage, self, #selector(imageSaved(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageSaved(image: UIImage!, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

    
    @IBAction func clickToShare(_ sender: Any) {
        let imageShare = [generatedImage]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func clickTOBack(_ sender: Any) {
        if isDisplay
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.navigationController?.popToRootViewController(animated: true)
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

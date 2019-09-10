//
//  ScannerSelectVC.swift
//  All Scan
//
//  Created by PC on 25/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class ScannerSelectVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var generateLbl: Label!
    @IBOutlet weak var scanCodeLbll: Label!
    
    @IBOutlet var generateBtn: UIButton!
    @IBOutlet var scanBtn: UIButton!
    
    let picker = UIImagePickerController()
    
    var selectedImage : UIImage = UIImage()
    var type : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        if type == 0 {
            titleLbl.text = "QR Code Scanner"
            generateLbl.text = "Generate QR Code"
            scanCodeLbll.text = "Scan QR Code"
            generateBtn.setImage(UIImage.init(named: "qr-code"), for: .normal)
            scanBtn.setImage(UIImage.init(named: "qrcodeScan"), for: .normal)
        }
        else if type == 1 {
            titleLbl.text = "Barcode Scanner"
            generateLbl.text = "Generate Barcode"
            scanCodeLbll.text = "Scan Barcode"
            generateBtn.setImage(UIImage.init(named: "barcode"), for: .normal)
            scanBtn.setImage(UIImage.init(named: "barcodeScan"), for: .normal)
        }
        else if type == 2 {
            titleLbl.text = "Document Scanner"
            generateLbl.text = "Camera"
            scanCodeLbll.text = "picture"
            generateBtn.setImage(UIImage.init(named: "camera"), for: .normal)
            scanBtn.setImage(UIImage.init(named: "picture"), for: .normal)
        }
        
    }
    
    @IBAction func clickToScanCode(_ sender: Any) {
        if type == 2 {
            openGallary()
        } else {
            let vc : QRBarcodeScannerVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeScannerVC") as! QRBarcodeScannerVC
            vc.type = type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickToGenerteCode(_ sender: Any) {
        if type == 2 {
            openCamera()
        } else {
            let vc : QRBarcodeGenratorVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeGenratorVC") as! QRBarcodeGenratorVC
            vc.type =  type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.dismiss(animated: true, completion: nil)
            
            let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
            vc.generatedImage = selectedImage
            vc.type = 2
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

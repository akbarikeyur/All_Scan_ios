//
//  SignatureVC.swift
//  All Scan
//
//  Created by PC on 26/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class SignatureVC: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet var signatureView: DrawingView!
    @IBOutlet var strockView: UIView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var sliderValueLbl: Label!
    
    var flag : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        strockView.isHidden = true
        sliderValueLbl.text = String(Int(slider.value))
        resetColor()
    }

    func resetColor()
    {
        signatureView.layer.backgroundColor = WhiteColor.cgColor
        signatureView.lineWidth = 5
        signatureView.drawColor = BlackColor
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToBgColor(_ sender: UIButton) {
        flag = false
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
    
    func setButtonColor (_ color: UIColor) {
        if flag {
            signatureView.drawColor = color
        }else {
            signatureView.layer.backgroundColor = color.cgColor
        }
        flag = false
    }
    
    @IBAction func clickToSignColor(_ sender: UIButton) {
        flag = true
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    @IBAction func clickToStrock(_ sender: Any) {
        strockView.isHidden = false
    }
    
    @IBAction func clickTostrockCancelBtn(_ sender: Any) {
         strockView.isHidden = true
    }
    
    @IBAction func clickToSlider(_ sender: UISlider) {
        strockView.isHidden = false
        sliderValueLbl.text = String(Int(sender.value))
        signatureView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func clickToClear(_ sender: Any) {
        signatureView.clear()
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        let img  = UIImage.init(view: signatureView)
        let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
        vc.generatedImage = img
        vc.type = 3
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}

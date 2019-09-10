//
//  QRBarcodeScannerVC.swift
//  All Scan
//
//  Created by Keyur on 24/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit
import AVFoundation

class QRBarcodeScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var titleTxt: Label!
    @IBOutlet weak var cameraView: UIView!
    
    var type : Int = 0
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 0 {
            titleTxt.text = "Scan QR Code"
        }
        else if type == 1 {
            titleTxt.text = "Scan Barcode"
        }
        else if type == 2 {
            titleTxt.text = "Scan Document"
        }
        capture()
    }
    
    
    // MARK: -  CAMERA VIDEO FOR SCAN QRCODE
    func capture()  {
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39, .aztec, .code39Mod43, .code93, .dataMatrix, .face]
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                cameraView.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                
                print("Error Device Input")
            }
        }
    }
    
    // MARK: - GENERATE QRCODE STRING
    
    let codeFrame : UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.green.cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("No Input Detected")
            codeFrame.frame = CGRect.zero
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        
        // Play system sound with custom mp3 file
        if let customSoundUrl = Bundle.main.url(forResource: "Beep", withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            //let systemSoundId: SystemSoundID = 1016 // to play apple's built in sound, no need for upper 3 lines
            
            AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
                AudioServicesDisposeSystemSoundID(customSoundId)
            }, nil)
            
            AudioServicesPlaySystemSound(customSoundId)
        }
        
        // Stop capturing and hence stop executing metadataOutput function over and over again
        captureSession?.stopRunning()
        
        self.videoPreviewLayer?.removeFromSuperlayer()
        codeFrame.removeFromSuperview()
        // store to firebase
        
        self.dismiss(animated: false, completion: nil)
        let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
        vc.content = stringCodeValue
        if type == 0
        {
            if let image = generateQRcode(from: stringCodeValue)
            {
                vc.generatedImage = image
            }
        }
        else if type == 1
        {
            if let image = generateBarcode(from: stringCodeValue)
            {
                vc.generatedImage = image
            }
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

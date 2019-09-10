//
//  Utility.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import AVFoundation
import Toaster


struct PLATFORM {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

//MARK:- Image Function
func compressImage(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img?.jpegData(compressionQuality: 1.0)
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

//MARK:- UI Function
func getTableBackgroundViewForNoData(_ str:String, size:CGSize) -> UIView{
    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    noDataLabel.text          = str.decoded
    noDataLabel.textColor     = ColorType.DarkGray.value
    //noDataLabel.font          = Regular18Font
    noDataLabel.textAlignment = .center
    return noDataLabel
}
func showCreditFormattedStr(_ credit:Int?) -> String{
    if(credit == nil){
        return "$0"
    }
    else{
        return "$" + String(credit!)
    }
}

func showEmailFormattedStr(_ str:String) -> String{
    let  arr:[String] = str.components(separatedBy: "@")
    if(arr.count == 2){
        if(arr[0].count > 2){
            return arr[0][0] + "***" + arr[0][arr[0].count-1] + arr[1]
        }
        else{
            return str
        }
    }
    return str
}

//MARK:- Toast
func displayToast(_ message:String)
{
    let toast = Toast(text: NSLocalizedString(message, comment: ""))
    toast.show()
}

func showAlertWithOption(_ title:String, message:String, btns:[String] = ["Yes", "Cancel"],completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    let rightBtn = UIAlertAction(title: btns[0], style: UIAlertAction.Style.default, handler: { (action) in
        completionConfirm()
    })
    let leftBtn = UIAlertAction(title: btns[1], style: UIAlertAction.Style.cancel, handler: { (action) in
        completionCancel()
    })
    myAlert.addAction(rightBtn)
    myAlert.addAction(leftBtn)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

func showAlert(_ title:String, message:String, completion: @escaping () -> Void) {
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    myAlert.view.tintColor = AppColor
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{ (action) in
        completion()
    })
    myAlert.addAction(okAction)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func displaySubViewWithScaleOutAnim(_ view:UIView){
    view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    view.alpha = 1
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0, options: [], animations: {() -> Void in
        view.transform = CGAffineTransform.identity
    }, completion: {(_ finished: Bool) -> Void in
    })
}
func displaySubViewWithScaleInAnim(_ view:UIView){
    UIView.animate(withDuration: 0.25, animations: {() -> Void in
        view.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        view.alpha = 0.0
    }, completion: {(_ finished: Bool) -> Void in
        view.removeFromSuperview()
    })
}

//MARK:- Open Url
func opwnUrlInSafari(strUrl : String)
{
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL(string : strUrl)!, options: [:]) { (isOpen) in
            
        }
    } else {
        // Fallback on earlier versions
    }
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

func imageFromColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

//MARK : - Add Credit Card
func showCardNumberFormattedStr(_ str:String, isRedacted:Bool = true) -> String{
    
    let tempStr:String = sendDetailByRemovingChar(sendDetailByRemovingChar(str, char:"-"), char: " ")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 4 || i == 8 || i == 12){
            retStr += "-"
        }
        retStr += tempStr[i]
    }
    if(isRedacted){
        var arr:[String] = retStr.components(separatedBy: "-")
        for i in 0..<arr.count{
            if(i == 1 || i == 2){
                arr[i] = "xxxx"
            }
        }
        retStr = arr.joined(separator: "-")
    }
    return retStr
}
func showCardExpDateFormattedStr(_ str:String) -> String{
    
    let tempStr:String = sendDetailByRemovingChar(str, char:"/")
    var retStr:String = ""
    for i in 0..<tempStr.count{
        if(i == 2){
            retStr += "/"
        }
        retStr += tempStr[i]
    }
    return retStr
}

//MARK:- Mobile Format



func sendDetailByRemovingChar(_ str:String, char:String = " ") -> String{
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}

func sendDetailByRemovingChar(_ attrStr:NSAttributedString, char:String = " ") -> String{
    let str:String = attrStr.string
    let regExp :String = char + "\n\t\r"
    return String(str.filter { !(regExp.contains($0))})
}


//MARK:- Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}


//MARK: - Local save
func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func storeImageInDocumentDirectory(image : UIImage, imageName : String)
{
    let imgName = imageName + ".jpg"
    let fileManager = FileManager.default
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imgName)
    //print(paths)
    let imageData = image.pngData()
    fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
}

func getImage(imageName : String) -> UIImage?
{
    let imgName = imageName + ".jpg"
    let fileManager = FileManager.default
    let imagePAth = (getDirectoryPath() as NSString).appendingPathComponent(imgName)
    if fileManager.fileExists(atPath: imagePAth){
        return UIImage(contentsOfFile: imagePAth)!
    }else{
        return nil
    }
}

func deleteImage(fromDirectory imageName: String) -> Bool {
    if imageName.count == 0 {
        return true
    }
    let imgName = imageName + (".jpg")
    let fileManager = FileManager.default
    
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imgName)
    
    if fileManager.fileExists(atPath: paths){
        try! fileManager.removeItem(atPath: paths)
        return true
    }else{
        print("Something wronge.")
        return false
    }
}

func deleteFileFromDirectory(filePath : String)
{
    let fileManager = FileManager.default
    
    if fileManager.fileExists(atPath: filePath){
        try! fileManager.removeItem(atPath: filePath)
    }else{
        print("Something wronge.")
    }
}

func storeVideoInDocumentDirectory(videoUrl : URL, videoName : String)
{
    let video_name = videoName + ".mp4"
    let fileManager = FileManager.default
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(video_name)
    //print(paths)
    let videoData = try? Data(contentsOf: videoUrl)
    fileManager.createFile(atPath: paths as String, contents: videoData, attributes: nil)
}

func getVideo(videoName : String) -> String?
{
    let video_name = videoName + ".mp4"
    let fileManager = FileManager.default
    let videoPAth = (getDirectoryPath() as NSString).appendingPathComponent(video_name)
    if fileManager.fileExists(atPath: videoPAth){
        return videoPAth
    }else{
        return nil
    }
}

func deleteVideo(fromDirectory videoName: String) -> Bool {
    if videoName.count == 0 {
        return true
    }
    let video_Name = videoName + (".mp4")
    let fileManager = FileManager.default
    
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(video_Name)
    
    if fileManager.fileExists(atPath: paths){
        try! fileManager.removeItem(atPath: paths)
        return true
    }else{
        print("Something wronge.")
        return false
    }
}

//CRATE THUMBNAIL
func getThumbnailFrom(path: String, btn : UIButton) {
    do {
        let asset = AVURLAsset(url: URL(string: path)! , options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
        let thumbnail = UIImage(cgImage: cgImage)
        btn.setBackgroundImage(thumbnail, for: .normal)
        //        return thumbnail
    } catch let error {
        
        print("*** Error generating thumbnail: \(error.localizedDescription)")
    }
}

func displayPriceWithCurrency(_ price : String) -> String
{
    return "$" + price
}

func getMonthArray() -> [String]
{
    var monthArr : [String] = [String]()
    for i in 1...12
    {
        monthArr.append(String(i))
    }
    return monthArr
}

func getCardYearArray() -> [String]
{
    var yearArr : [String] = [String]()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY"
    let currentYear = dateFormatter.string(from: Date())
    
    for i in 0...30
    {
        yearArr.append(String(Int(currentYear)! + i))
    }
    return yearArr
}

func generateQRcode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        if let image = filter.outputImage {
            let size = image.extent.integral
            let output = CGSize(width: 250, height: 250)
            let matrix = CGAffineTransform(scaleX: output.width / size.width, y: output.height / size.height)
            UIGraphicsBeginImageContextWithOptions(output, false, 0)
            defer { UIGraphicsEndImageContext() }
            UIImage(ciImage: image.transformed(by: matrix))
                .draw(in: CGRect(origin: .zero, size: output))
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
    
    return nil
    
}


func generateBarcode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
        filter.setDefaults()
        //Margin
        filter.setValue(7.00, forKey: "inputQuietSpace")
        filter.setValue(data, forKey: "inputMessage")
        //Scaling
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        if let output = filter.outputImage?.transformed(by: transform) {
            let context:CIContext = CIContext.init(options: nil)
            let cgImage:CGImage = context.createCGImage(output, from: output.extent)!
            let rawImage:UIImage = UIImage.init(cgImage: cgImage)
            
            //Refinement code to allow conversion to NSData or share UIImage. Code here:
            //http://stackoverflow.com/questions/2240395/uiimage-created-from-cgimageref-fails-with-uiimagepngrepresentation
            let cgimage: CGImage = (rawImage.cgImage)!
            let cropZone = CGRect(x: 0, y: 0, width: Int(rawImage.size.width), height: Int(rawImage.size.height))
            let cWidth: size_t  = size_t(cropZone.size.width)
            let cHeight: size_t  = size_t(cropZone.size.height)
            let bitsPerComponent: size_t = cgimage.bitsPerComponent
            //THE OPERATIONS ORDER COULD BE FLIPPED, ALTHOUGH, IT DOESN'T AFFECT THE RESULT
            let bytesPerRow = (cgimage.bytesPerRow) / (cgimage.width  * cWidth)
            
            let context2: CGContext = CGContext(data: nil, width: cWidth, height: cHeight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: cgimage.bitmapInfo.rawValue)!
            
            context2.draw(cgimage, in: cropZone)
            
            let result: CGImage  = context2.makeImage()!
            let finalImage = UIImage(cgImage: result)
            
            return finalImage
            
        }
    }
    
    return nil
}

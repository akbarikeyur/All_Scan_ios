//
//  StartVC.swift
//  All Scan
//
//  Created by PC on 25/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class StartVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var arr = ["QR","Barcode","Document","Signature","Mywork","Setting"]
    var img = ["qr","bar_code","document","signature","account","setting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryCollectionView.register(UINib.init(nibName: "moreCVC", bundle: nil), forCellWithReuseIdentifier: "moreCVC")
        categoryCollectionView.delegate = self
        
    }
    
    //MARK: - CollectionView Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "moreCVC", for: indexPath) as! moreCVC
        cell.lbl.text = arr[indexPath.row]
        cell.imgBtn.setImage(UIImage(named: img[indexPath.row]), for: .normal)
        collectionViewHeightConstraint.constant = categoryCollectionView.contentSize.height
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            let vc : ScannerSelectVC = self.storyboard?.instantiateViewController(withIdentifier: "ScannerSelectVC") as! ScannerSelectVC
            vc.type = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc : SignatureVC = self.storyboard?.instantiateViewController(withIdentifier: "SignatureVC") as! SignatureVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc : MyWorkVC = self.storyboard?.instantiateViewController(withIdentifier: "MyWorkVC") as! MyWorkVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc : SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
       
        let Width = categoryCollectionView.frame.size.width/3
        let Height = Width
        return CGSize(width: Width, height: Height)
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToHelp(_ sender: Any) {
        let vc : AppGuidenanceVC = self.storyboard?.instantiateViewController(withIdentifier: "AppGuidenanceVC") as! AppGuidenanceVC
        self.navigationController?.present(vc, animated: true, completion: {
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

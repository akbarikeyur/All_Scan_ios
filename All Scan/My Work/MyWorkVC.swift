//
//  MyWorkVC.swift
//  All Scan
//
//  Created by PC on 25/01/19.
//  Copyright © 2019 Amisha. All rights reserved.
//

import UIKit

class MyWorkVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataFoundLbl: Label!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib.init(nibName: "CustomMyWorkTVC", bundle: nil), forCellReuseIdentifier: "CustomMyWorkTVC")
        
        tblView.backgroundColor = UIColor.clear
        tblView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        noDataFoundLbl.isHidden = (AppModel.shared.MY_WORK.count > 0)
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Tableview Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppModel.shared.MY_WORK.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomMyWorkTVC = tblView.dequeueReusableCell(withIdentifier: "CustomMyWorkTVC", for: indexPath) as! CustomMyWorkTVC
        
        let work = AppModel.shared.MY_WORK[indexPath.row]
        cell.imgView.image = getImage(imageName: work.image)
        cell.contentTxtView.text = work.content
        cell.contentTxtView.delegate = self
//        cell.durationLbl.text = getTimestampToDateString(Double(work.date)!)
        cell.durationLbl.text = ""
        if work.type == 3 {
            cell.contentTxtView.text = "Signature"
        }
        cell.contentView.backgroundColor = ClearColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let detail = UITableViewRowAction(style: .default, title: "Detail") { (action, indexPath) in
            let vc : QRBarcodeDisplayVC = self.storyboard?.instantiateViewController(withIdentifier: "QRBarcodeDisplayVC") as! QRBarcodeDisplayVC
            vc.newWork = AppModel.shared.MY_WORK[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        detail.backgroundColor = AppColor
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            AppModel.shared.MY_WORK.remove(at: indexPath.row)
            self.tblView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.noDataFoundLbl.isHidden = (AppModel.shared.MY_WORK.count > 0)
            updateMyWorkHistory()
        }
        
        return [delete, detail]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//
//  AppModel.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd on 1/2/18.
//  Copyright © 2018 ToShare Pty. Ltd. All rights reserved.
//

import UIKit

class AppModel: NSObject {
    static let shared = AppModel()
    var MY_WORK : [WorkModel]!
}

class WorkModel:AppModel{
    
    var uID : String!
    var type : Int!
    var image : String!
    var content : String!
    var date : String!
    
    override init(){
        uID = ""
        type = -1
        image = ""
        content = ""
        date = ""
    }
    init(dict : [String : Any])
    {
        uID = ""
        type = -1
        image = ""
        content = ""
        date = ""
        
        if let Id = dict["uID"] as? String{
            uID = Id
        }
        if let temp = dict["type"] as? Int {
            type = temp
        }
        if let temp = dict["image"] as? String{
            image = temp
        }
        if let temp = dict["content"] as? String{
            content = temp
        }
        if let temp = dict["date"] as? String{
            date = temp
        }
    }
    
    func dictionary() -> [String:Any]{
        return ["uID":uID, "type":type,"image" : image, "content" : content, "date" : date]
    }
    
    func toJson(_ dict:[String:Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
}

//
//  Preference.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
    
    let IS_USER_LOGIN_KEY       =   "IS_USER_LOGIN"
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: key)
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - My Work History
func saveMyWorkHistory(newWork : WorkModel)
{
    AppModel.shared.MY_WORK = getMyWorkHistory()
    let index = AppModel.shared.MY_WORK.firstIndex { (temp) -> Bool in
        temp.uID == newWork.uID
    }
    if index != nil
    {
        AppModel.shared.MY_WORK[index!] = newWork
    }
    else
    {
        AppModel.shared.MY_WORK.append(newWork)
    }
    
    var temData : [[String : Any]] = [[String : Any]]()
    for dict in AppModel.shared.MY_WORK
    {
        temData.append(dict.dictionary())
    }
    setDataToPreference(data: temData as AnyObject, forKey: "my_work_history")
}

func updateMyWorkHistory()
{
    var temData : [[String : Any]] = [[String : Any]]()
    for dict in AppModel.shared.MY_WORK
    {
        temData.append(dict.dictionary())
    }
    setDataToPreference(data: temData as AnyObject, forKey: "my_work_history")
}

func getMyWorkHistory() -> [WorkModel]
{
    AppModel.shared.MY_WORK = [WorkModel]()
    if let data : [[String : Any]] = getDataFromPreference(key: "my_work_history") as? [[String : Any]]
    {
        for temp in data
        {
            AppModel.shared.MY_WORK.append(WorkModel.init(dict: temp))
        }
    }
    return AppModel.shared.MY_WORK
}

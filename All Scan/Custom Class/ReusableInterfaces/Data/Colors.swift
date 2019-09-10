//
//  Colors.swift
//  Cozy Up
//
//  Created by Amisha on 15/10/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var DarkGrayColor : UIColor = colorFromHex(hex: "4C4C4C") //2
var LightGrayColor : UIColor = colorFromHex(hex: "9A9A9A") //3
var ExtraLightGrayColor : UIColor = colorFromHex(hex: "B2B0B0") //4

var AppColor : UIColor = colorFromHex(hex: "4AB353") //5
var BlackColor : UIColor = UIColor.black   //6

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case DarkGray = 2
    case LightGray = 3
    case ExtraLightGray = 4
    case App = 5
    case Black = 6
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
            case .Clear: //0
                return ClearColor
            case .White: //1
                return WhiteColor
            case .DarkGray: //2
                return DarkGrayColor
            case .LightGray: //3
                return LightGrayColor
            case .ExtraLightGray: //4
                return ExtraLightGrayColor
            case .App : //5
                return AppColor
            case .Black : //6
                return BlackColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case App = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
//                    PinkColor.cgColor,
//                    PurpleColor.cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}


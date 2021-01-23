//
//  NightOrDayMode.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 1/19/21.
//

import Foundation
import UIKit

protocol LightDarkModes {
    func ligtAndDark(viewColor: UIColor, textColor: UIColor) -> Bool
}

class DayStyle: LightDarkModes {
    func ligtAndDark(viewColor: UIColor, textColor: UIColor) -> Bool {
        return true
    }
}

class NightStyle: LightDarkModes {
    func ligtAndDark(viewColor: UIColor, textColor: UIColor) -> Bool {
        return true
    }
}
//class TimeChecker(viewColor: UIColor, textColor: UIColor) -> Bool {
//    let date = Date()
//    let calendar = Calendar.current
//    let hour = calendar.component( .hour, from: date)
//
//    if hour <= 19 && hour >= 8 {
//        return true
//    } else {
//        retu
//    }
//
//}

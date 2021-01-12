//
//  CheckLoginPassword.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 1/12/21.
//

import UIKit

class CheckLoginPassword {
    func checkLoginAndPassword(userName: String, password: String) -> Bool {
        
        if userName != "" && password != "" {
            return true
        }
        else {
            return false
        }
    }
}

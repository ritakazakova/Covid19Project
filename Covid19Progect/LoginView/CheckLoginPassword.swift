import UIKit

protocol FieldValidator {
    func checkLoginAndPassword(userName: String, password: String) -> Bool
}

protocol MinCharacterCounts {
    func checkCharacterCounts(userName: String, password: String) -> Bool
}

class CheckLoginPassword: FieldValidator {

    func checkLoginAndPassword(userName: String, password: String) -> Bool {
        if userName != "" && password != "" {
            return true
        }
        else {
            return false
        }
    }
}

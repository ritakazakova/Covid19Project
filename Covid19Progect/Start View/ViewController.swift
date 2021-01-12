//
//  ViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    let storage = UserDefaults.standard
    let keyForUsername = "Value Username"
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userNameTopView: NSLayoutConstraint!
    @IBOutlet var loginBottomView: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
                
        userNameTopView.constant = 100
        loginBottomView.constant = 100
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          }, completion: nil)
        
        if let writeASavedUsername = storage.string(forKey: keyForUsername) {
            userName.text = writeASavedUsername
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        login.isEnabled = false
        
        password.text = ""
        
        userNameTopView.constant += view.bounds.maxY
        loginBottomView.constant -= view.bounds.maxY
    }
    
    
    func saveUsername() {
        
        storage.setValue(userName.text, forKey: keyForUsername)
        storage.synchronize()
    }
    
    
    @IBAction func PressedLogin(_ sender: UIButton) {
        
        saveUsername()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        present(viewController, animated: true, completion: nil)
    }
    
    func textFieldWithText() {
        let checkLoginPassword = CheckLoginPassword()
        if checkLoginPassword.checkLoginAndPassword(userName: userName.text!, password: password.text!) {
            login.isEnabled = true
        } else {
            login.isEnabled = false
        }
    }
    
    
    @IBAction func userNameAction(_ sender: UITextField) {
        textFieldWithText()
    }
    
    
    @IBAction func passwordAction(_ sender: UITextField) {
        textFieldWithText()
    }
    
}

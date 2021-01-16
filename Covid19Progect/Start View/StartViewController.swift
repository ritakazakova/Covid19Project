//
//  ViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/1/20.
//

import UIKit
import Swinject

class StartViewController: UIViewController {
    
    private let storage = UserDefaults.standard
    private let keyForUsername = "Value Username"
    
    @IBOutlet private weak var login: UIButton!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var userNameTopView: NSLayoutConstraint!
    @IBOutlet private var loginBottomView: NSLayoutConstraint!
    
    
    private let validator = Dependency().container.resolve(FieldValidator.self)
    
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
    
    
    private func saveUsername() {
        
        storage.setValue(userName.text, forKey: keyForUsername)
        storage.synchronize()
    }
    
    
    @IBAction private func PressedLogin(_ sender: UIButton) {
        
        saveUsername()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        present(viewController, animated: true, completion: nil)
    }
    
    private func textFieldWithText() {
        if validator?.checkLoginAndPassword(userName: userName.text ?? "", password: password.text ?? "") == true {
            login.isEnabled = true
        } else {
            login.isEnabled = false
        }
    }
    
    
    @IBAction private func userNameAction(_ sender: UITextField) {
        textFieldWithText()
    }
    
    
    @IBAction private func passwordAction(_ sender: UITextField) {
        textFieldWithText()
    }
    
}

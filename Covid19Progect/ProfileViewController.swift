//
//  ProfileViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/7/20.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameLabel.text = StartUsername.username
        userNameLabel.textColor = .black
        
    }
    
    @IBAction func pressedLogout(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}

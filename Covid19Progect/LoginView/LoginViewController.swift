import UIKit
import Swinject
import KeychainAccess


class LoginViewController: UIViewController {
    
    private let lastUsernameKey = "Value Username"
    private let keyForPassword = "Value Password"
    
    let keychain = Dependency().container.resolve(Keychain.self)
    
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
        
        if let savedUsername = keychain?[lastUsernameKey] {
            userName.text = savedUsername
            password.text = keychain?[savedUsername]
        }
        
        textFieldWithText()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        NotificationManager().notification()
        NotificationManager().scheduleNotification(notificationType: "")
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameTopView.constant += view.bounds.maxY
        loginBottomView.constant -= view.bounds.maxY
    }
    
    
    private func saveUsername() {
        
        guard let userNameText = userName.text, let passwordText = password.text else { return }
        
        keychain?[userNameText] = passwordText
        keychain?[lastUsernameKey] = userNameText
        
    }
    
    
    @IBAction private func pressedLogin(_ sender: UIButton) {
        
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

import UIKit
import KeychainAccess

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychainFromDependency = Dependency().container.resolve(Keychain.self)
        self.userNameLabel.text = keychainFromDependency?["Value Username"]
        userNameLabel.textColor = .black
        
    }
    
    @IBAction func pressedLogout(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}

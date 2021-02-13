import UIKit

class DetailCasesViewController: UIViewController {
    
    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var titleCountry: UINavigationItem!
    
    var cases: Case?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        
        if let recoveredInt1 = cases?.recovered {
            recoveredLabel.text = "\(NSLocalizedString("Recovered", comment: "")): \(recoveredInt1)"
        } else {
            recoveredLabel.text = "\(NSLocalizedString("Recovered", comment: "")): -"
        }
        
        infectedLabel.text = "\(NSLocalizedString("Infected", comment: "")): \(cases!.infected)"
        titleCountry.title = cases!.country
        
    }
    
}

//
//  DetailProfileViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/8/20.
//

import UIKit

class DetailCasesViewController: UIViewController {
    
    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var titleCountry: UINavigationItem!
    
    var cases: Case?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        
        if let recoveredInt1 = cases?.recovered {
            recoveredLabel.text = "Recovered: \(recoveredInt1)"
        } else {
            recoveredLabel.text = "Recovered: -"
        }
        
        infectedLabel.text = "Infected: \(cases!.infected)"
        titleCountry.title = cases!.country
        
    }
    
}

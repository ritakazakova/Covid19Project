//
//  DetailProfileViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/8/20.
//

import UIKit

class DetailCasesViewController: UIViewController {
    
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var titleCountry: UINavigationItem!
    
    
    var country: Country?
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        confirmedLabel.text = "Confirmed: \(country!.latest.confirmed)"
        deathLabel.text = "Death: \(country!.latest.death)"
        titleCountry.title = country!.country
        
    }
    
}

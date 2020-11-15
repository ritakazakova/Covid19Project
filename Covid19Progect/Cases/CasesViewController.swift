//
//  CasesViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/7/20.
//

import UIKit


class CasesViewController: UITableViewController {
    
    let arrayCountries: [Country] = [Country(country: "German", latest: Latest.init(confirmed: 5, death: 4)), Country(country: "Belarus", latest: Latest.init(confirmed: 3, death: 1)), Country(country: "Igypt", latest: Latest.init(confirmed: 8, death: 3))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCountries.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailCasesViewController") as! DetailCasesViewController
        viewController.country = arrayCountries[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
        
        let textInCell = "\(arrayCountries[indexPath.row].country)  Confirmed: \(arrayCountries[indexPath.row].latest.confirmed)  Death: \(arrayCountries[indexPath.row].latest.death)"
        
        
        cell.textLabel?.text = textInCell
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
}




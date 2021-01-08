//
//  CasesViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/7/20.
//

import UIKit


class CasesViewController: UITableViewController {
    
    var arrayCountries = [Case]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataForCase()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefreshCases), for: .valueChanged)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCountries.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailCasesViewController") as! DetailCasesViewController
        viewController.cases = arrayCountries[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
        let recoveredString: String
        
        if let recoveredInt = arrayCountries[indexPath.row].recovered {
            recoveredString = "\(recoveredInt)"
        } else {
            recoveredString = "-"
        }
        
        let textInCell = "\(arrayCountries[indexPath.row].country)  \(NSLocalizedString("Infected", comment: "")): \(arrayCountries[indexPath.row].infected)  \(NSLocalizedString("Recovered", comment: "")): \(recoveredString) "
        
        cell.textLabel?.text = textInCell
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    
    func loadDataForCase() {
        let session = URLSession(configuration: .default)
        
        guard let sessionURL = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true")
        else {return}
        let urlRequest = URLRequest(url: sessionURL)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([Case].self, from: data)
                    self.arrayCountries = response
                    print(response.count)
                    DispatchQueue.main.async { [self] in
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    @objc func didPullToRefreshCases() {
        
        loadDataForCase()
    }
}

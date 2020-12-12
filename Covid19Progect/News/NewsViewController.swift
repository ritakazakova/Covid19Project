//
//  NewsViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/7/20.
//

import UIKit

private let reuseIdentifier = "CollectionCell"


class NewsViewController: UICollectionViewController {
    
    
    var arrayArticle = [Article]()
    var arrayImage = [ImageInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacing: CGFloat = 20
        let sizeCell = (UIScreen.main.bounds.width - 3 * spacing) / 2
        
        let cellSize = CGSize(width: sizeCell, height: sizeCell)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        loadDataForNews()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayArticle.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         
        let dateString = "\(arrayArticle[indexPath.row].publishedAt)"
        let date = dateFormatter.date(from: dateString)
        
        let prettyDateFormatter = DateFormatter()
        prettyDateFormatter.dateStyle = .medium
        prettyDateFormatter.timeStyle = .short
        
        let outputDate: String?
        
        if let dateDate = date {
            outputDate = prettyDateFormatter.string(from: dateDate)
        } else {
            outputDate = nil
        }
        
        cell.authorLabel?.text = arrayArticle[indexPath.row].author
        cell.titleLabel?.text = arrayArticle[indexPath.row].title
        cell.dateLabel.text = outputDate
        //        cell.imageNews?.image = arrayArticle[indexPath.row].urlToImage
        
        return cell
    }
    
    func loadDataForNews() {
        let session = URLSession(configuration: .default)
        
        guard let sessionURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a71f3e7747974cdaa079584c7db4e21f")
        else {return}
        let urlRequest = URLRequest(url: sessionURL)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Articles.self, from: data)
                    self.arrayArticle = response.articles
                    for element in response.articles{
//                        self.arrayImage.append(ImageInfo(image: nil, url: urlRequest, isLoading: <#T##Bool#>))
                        
                    }
                    
                    print(response.articles.count)
                    DispatchQueue.main.async { [self] in
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
}

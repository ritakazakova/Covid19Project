import UIKit
import SafariServices

private let reuseIdentifier = "CollectionCell"

class NewsViewController: UICollectionViewController {
    
    
    var arrayArticle = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacing: CGFloat = 3
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
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefreshNews), for: .valueChanged)
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
        
        
        if let image = arrayArticle[indexPath.row].imageInfo.image {
            cell.imageNews.image = image
        } else {
            let noImage = UIImage(named: "no_img")!
            cell.imageNews.image = noImage
            if let imageURL = arrayArticle[indexPath.row].urlToImage {
                if arrayArticle[indexPath.row].imageInfo.isLoading == false {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: imageURL) {
                            self.arrayArticle[indexPath.row].imageInfo.isLoading = false
                            let imageFromData = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.arrayArticle[indexPath.row].imageInfo.image = imageFromData
                                self.collectionView.reloadData()
                                self.collectionView.refreshControl?.endRefreshing()
                            }
                        }
                    }
                }
                arrayArticle[indexPath.row].imageInfo.isLoading = true
            }
        }
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
                    for _ in response.articles{
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
    
    @objc func didPullToRefreshNews() {
        
        loadDataForNews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openLink(urlForNews: arrayArticle[indexPath.row].url)
    }
    
    private func openLink(urlForNews: URL?) {
        guard let urlNews = urlForNews else {
            return
        }
        let safariVC = SFSafariViewController(url: urlNews)
        present(safariVC, animated: true, completion: nil)
    }
}

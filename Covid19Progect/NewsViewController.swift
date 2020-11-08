//
//  NewsViewController.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/7/20.
//

import UIKit

private let reuseIdentifire = "CollectionCell"

struct Article: Codable {
    let author: String
    let title: String
}

class NewsViewController: UICollectionViewController {
    
    
    let arrayArticle: [Article] = [Article.init(author: "Author1", title: "Title1"), Article.init(author: "Author2", title: "Title2"), Article.init(author: "Author3", title: "Title3"), Article.init(author: "Author4", title: "Title4"), Article.init(author: "Author5", title: "Title5")]
    
    
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
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayArticle.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as! NewsCollectionViewCell
        
        cell.authorLabel?.text = arrayArticle[indexPath.row].author
        cell.titleLabel?.text = arrayArticle[indexPath.row].title
        
        return cell
    }
    
}

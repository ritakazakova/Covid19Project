//
//  StructArticle.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/15/20.
//

import UIKit


struct Article: Codable {
    let author: String?
    let title: String
    let urlToImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case author, title, urlToImage
    }
    
    init(author: String? = nil, title: String? = nil, urlToImage: String? = nil) {
        self.author = author
        self.title = title!
        self.urlToImage = urlToImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try? container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        urlToImage = try? container.decode(String.self, forKey: .urlToImage)
    }
}

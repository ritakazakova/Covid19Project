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
    let publishedAt: String
    let urlToImage: URL?
    var imageInfo: ImageInfo
    
    private enum CodingKeys: String, CodingKey {
        case author, title, publishedAt, urlToImage
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try? container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        publishedAt = try container.decode(String.self, forKey: .publishedAt)
        urlToImage = try? container.decode(URL.self, forKey: .urlToImage)
        imageInfo = ImageInfo(image: nil, urlImage: urlToImage, isLoading: false)
    }
}

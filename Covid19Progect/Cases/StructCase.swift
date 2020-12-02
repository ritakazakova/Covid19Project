//
//  StructCountry.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 11/15/20.
//

import UIKit


struct Case: Decodable {
    var country: String
    var infected: Int
    var recovered: Int?
    
    private enum CodingKeys: String, CodingKey {
        case infected, recovered, country
    }
    
    init(infected: Int? = nil, recovered: Int? = nil, country: String? = nil) {
        self.infected = infected!
        self.recovered = recovered
        self.country = country!
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        infected = try container.decode(Int.self, forKey: .infected)
        country = try container.decode(String.self, forKey: .country)
        recovered = try? container.decode(Int.self, forKey: .recovered)
    }
}

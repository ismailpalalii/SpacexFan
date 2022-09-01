//
//  Rockets.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import Foundation

// MARK: Rockets Model

struct Rockets {
    let name: String
    let isActive: Bool
    let successRatePct: Int
    let country: String
    let company: String
    let description: String
    let wikipediaURL: URL
    let images: [URL]
    let id: String
}

extension Rockets: Decodable {
    enum RocketKeys: String, CodingKey {
        case name = "name"
        case isActive = "active"
        case successRatePct = "success_rate_pct"
        case country = "country"
        case company = "company"
        case description = "description"
        case wikipediaURL = "wikipedia"
        case images = "flickr_images"
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RocketKeys.self)
        name = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        successRatePct = try container.decode(Int.self, forKey: .successRatePct)
        country = try container.decode(String.self, forKey: .country)
        company = try container.decode(String.self, forKey: .company)
        description = try container.decode(String.self, forKey: .description)
        id = try container.decode(String.self, forKey: .id)
        wikipediaURL = try container.decode(URL.self, forKey: .wikipediaURL)
        images = try container.decode([URL].self, forKey: .images)

    }
}

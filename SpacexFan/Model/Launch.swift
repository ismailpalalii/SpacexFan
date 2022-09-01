//
//  Launch.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import Foundation

// MARK: Launch Model

struct Launch {
    let flightNumber: Int
    let missionName: String
    let missionDetails: String?
    let date: Date
    let rocketID: String?
    let smallPatchURL: URL?
    let largePatchURL: URL?
    let campaignURL: URL?
    let success: Bool?
}

extension Launch: Decodable {
    enum LaunchKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "name"
        case missionDetails = "details"
        case date = "date_utc"
        case rocketID = "rocket"
        case success = "success"
        case links

        enum LinksKeys: String, CodingKey {
            case patch = "patch"
            case reddit = "reddit"

            enum PatchKeys: String, CodingKey {
                case smallPatch = "small"
                case largePatch = "large"
            }

            enum RedditKeys: String, CodingKey {
                case campaign = "campaign"
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LaunchKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        missionName = try container.decode(String.self, forKey: .missionName)
        missionDetails = try container.decodeIfPresent(String.self, forKey: .missionDetails)
        date = try container.decode(Date.self, forKey: .date)
        rocketID = try container.decode(String.self, forKey: .rocketID)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)

        let linksContainer = try container.nestedContainer(keyedBy: LaunchKeys.LinksKeys.self, forKey: .links)
        let patchContainer = try linksContainer.nestedContainer(keyedBy: LaunchKeys.LinksKeys.PatchKeys.self, forKey: .patch)
        let redditContainer = try linksContainer.nestedContainer(keyedBy: LaunchKeys.LinksKeys.RedditKeys.self, forKey: .reddit)

        smallPatchURL = try patchContainer.decodeIfPresent(URL.self, forKey: .smallPatch)
        largePatchURL = try patchContainer.decodeIfPresent(URL.self, forKey: .largePatch)

        campaignURL = try redditContainer.decodeIfPresent(URL.self, forKey: .campaign)
    }
}


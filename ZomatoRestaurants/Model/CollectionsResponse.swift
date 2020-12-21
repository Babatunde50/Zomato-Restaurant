//
//  File.swift
//  RestaurantApp
//
//  Created by Tunde Ola on 12/16/20.
//

import Foundation

struct CollectionsResponse : Codable {
    let collections : [Collections]?
    let hasMore : Int?
    let shareUrl : String?
    let displayText : String?
    let hasTotal : Int?
    let userHasAddresses : Bool?

    enum CodingKeys: String, CodingKey {

        case collections = "collections"
        case hasMore = "has_more"
        case shareUrl = "share_url"
        case displayText = "display_text"
        case hasTotal = "has_total"
        case userHasAddresses = "user_has_addresses"
    }
}



struct Collection : Codable {
    let collectionId : Int?
    let resCount : Int?
    let imageUrl : String?
    let url : String?
    let title : String?
    let description : String?
    let shareUrl : String?

    enum CodingKeys: String, CodingKey {

        case collectionId = "collection_id"
        case resCount = "res_count"
        case imageUrl = "image_url"
        case url = "url"
        case title = "title"
        case description = "description"
        case shareUrl = "share_url"
    }

}

struct Collections : Codable {
    let collection : Collection?

    enum CodingKeys: String, CodingKey {

        case collection = "collection"
    }


}


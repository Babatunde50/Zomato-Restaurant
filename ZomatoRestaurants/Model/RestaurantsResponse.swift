//
//  RestaurantsResponse.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/17/20.
//

import Foundation

struct RestaurantsResponse: Codable {
    let restaurants: [Restaurants]
}

struct Restaurants: Codable {
    let restaurant: Restaurant
}

struct Restaurant: Codable {
    let id: String
    let name: String
    let timings: String
    let priceRange: Int
    let currency: String
    let featuredImage: String
    let userRating: Rating
    let location: Location
    let highlights: [String]
    let allReviewsCount: Int
    let photosUrl: String
    let menuUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case timings = "timings"
        case priceRange = "price_range"
        case currency = "currency"
        case featuredImage = "featured_image"
        case userRating = "user_rating"
        case location = "location"
        case highlights = "highlights"
        case allReviewsCount = "all_reviews_count"
        case photosUrl = "photos_url"
        case menuUrl = "menu_url"
    }
}

struct Rating : Codable {
    let ratingText : String?
    let ratingColor : String?
    let votes : Int?
    let ratingObj: RatingObj

    enum CodingKeys: String, CodingKey {
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case votes = "votes"
        case ratingObj = "rating_obj"
    }
}

    struct RatingObj: Codable {
        let title: Text
    }
    
    struct Text: Codable {
        let text: String
    }

struct Location: Codable {
    let address: String?
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

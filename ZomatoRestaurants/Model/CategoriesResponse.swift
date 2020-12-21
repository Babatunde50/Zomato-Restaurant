//
//  CategoriesResponse.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/16/20.
//

import Foundation

struct CategoryResponse: Decodable {
    let categories: [Categories]
}

struct Categories: Codable {
    let categories: Category
}

struct Category: Codable {
    let id: Int?
    let name: String?
}

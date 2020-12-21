//
//  APIClient.swift
//  RestaurantApp
//
//  Created by Tunde Ola on 12/16/20.
//

import Foundation

class APIClient {
    
    enum Endpoints {
        static let base = "https://developers.zomato.com/api/v2.1"
        static let apiKey = "a29edffe1d3ed0c277a5d53f4e70c6da"
        
        case getCollections(cityId: Int)
        case getCategories
        case getCategoryRestaurant(categoryId: Int)
        case getCollectionRestaurant(collectionId: Int)
        
        var stringValue: String {
            switch self {
                case .getCollections(let cityId):
                    return "\(Endpoints.base)/collections?city_id=\(cityId)"
                case .getCategories:
                    return "\(Endpoints.base)/categories"
                case .getCategoryRestaurant(let categoryId):
                    return "\(Endpoints.base)/search?categories=\(categoryId)"
                case .getCollectionRestaurant(let collectionId):
                    return "\(Endpoints.base)/search?collection_id=\(collectionId)"
            }
        }
        
        var url: URLRequest {
            print(stringValue, "url")
            var request = URLRequest( url: URL(string: stringValue)!)
            let headers = [
                "user-key": Endpoints.apiKey
            ]
            request.allHTTPHeaderFields = headers
            return request
        }
    }
    
    class func GetRestaurants(cityId: Int = 1 , completion: @escaping ([Collections]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: APIClient.Endpoints.getCollections( cityId: cityId).url) { data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(CollectionsResponse.self, from: data)
                completion(responseObject.collections, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    class func GetCategories(completion: @escaping (CategoryResponse?, Error? ) -> Void ) {
        let task = URLSession.shared.dataTask(with: APIClient.Endpoints.getCategories.url) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(CategoryResponse.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
            
        }
        
        task.resume()
    }
    
    class func GetCategoryRestaurant(categoryId: Int, completion: @escaping (RestaurantsResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: APIClient.Endpoints.getCategoryRestaurant(categoryId: categoryId).url) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(RestaurantsResponse.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
            
        }
        
        task.resume()
    }
    
    class func GetCollectionRestaurant(collectionId: Int, completion: @escaping (RestaurantsResponse?, Error?) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: APIClient.Endpoints.getCollectionRestaurant(collectionId: collectionId).url) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(RestaurantsResponse.self, from: data)
                print(responseObject, "Restaurants")
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
            
        }
        
        task.resume()
    }
    
    
    }
    
    
    


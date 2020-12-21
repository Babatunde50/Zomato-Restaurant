//
//  RestaurantTableViewCell.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/17/20.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIView!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRatings: UILabel!
    @IBOutlet weak var restaurantTiming: UILabel!
    @IBOutlet weak var restaurantPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with restaurant: Restaurant) {
        var data: Data?
        if restaurant.featuredImage.count == 0 {
            data = try? Data(contentsOf: URL(string: "https://hazelwood-dental.com/wp-content/themes/hazelwood/images/no-image-found-360x250.png" )!)
        } else {
            data = try? Data(contentsOf: URL(string: restaurant.featuredImage)!)
        }
        restaurantImage.image = UIImage(data: data!)
        restaurantName.text = restaurant.name
        restaurantRatings.text = restaurant.userRating.ratingObj.title.text + " / 5.0 "
        restaurantPrice.text = restaurant.currency + String(restaurant.priceRange)
        restaurantTiming.text = restaurant.timings
    }
}

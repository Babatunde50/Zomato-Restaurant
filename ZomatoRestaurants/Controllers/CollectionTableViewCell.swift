//
//  CollectionTableViewCell.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/16/20.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionDescription: UILabel!
    @IBOutlet weak var totalRestaurants: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with collection: Collection) {
        let data = try? Data(contentsOf: URL(string: collection.imageUrl!)! )
        collectionImageView.image = UIImage(data: data!)
        collectionTitle.text = collection.title
        collectionDescription.text = collection.description
        totalRestaurants.text = String(collection.resCount!) + " Restaurants"
    }

}

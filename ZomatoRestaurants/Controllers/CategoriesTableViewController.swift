//
//  CategoriesTableViewController.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/16/20.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController {
    
    var categories = [Categories]()
    var selectedCategory: Category?
    var savedRestaurants: [Restaurants]?
    var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVES", style: UIBarButtonItem.Style(rawValue: 1)!, target: self, action: #selector(viewLocalRestaurants))
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        APIClient.GetCategories { (result, error) in
            if error != nil {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "An error occured", message: error!.localizedDescription , preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
                return
            }
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.categories = result.categories
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.tableView.reloadData()
            }
            
        }

    }
    
    @objc func viewLocalRestaurants() {
        var restaurants = [Restaurants]()
        if let localRestaurants = fetchRequestSetup() {
            for restaurant in localRestaurants {
                let text = Text(text: restaurant.rating!)
                let ratingObj = RatingObj(title: text)
                let rating = Rating(ratingText: nil, ratingColor: nil, votes: nil, ratingObj: ratingObj )
                let location = Location(address: restaurant.address, latitude: restaurant.latitude, longitude: restaurant.longitude)
                let convertedRestaurant = Restaurant(id: restaurant.id!, name: restaurant.name!, timings: restaurant.timings!, priceRange: Int(restaurant.priceRange), currency: restaurant.currency!, featuredImage: restaurant.featuredImage!, userRating: rating, location: location, highlights: restaurant.highlights!, allReviewsCount: Int(restaurant.allReviewsCount), photosUrl: restaurant.photosUrl!, menuUrl: restaurant.menuUrl!)
                restaurants.append(Restaurants(restaurant: convertedRestaurant ))
            }
            savedRestaurants = restaurants
            performSegue(withIdentifier: "restaurantCategoryList", sender: self)
        }
    }
    
    func fetchRequestSetup() -> [LocalRestaurants]? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LocalRestaurants> = LocalRestaurants.fetchRequest()
        let savedRestaurants = try? context.fetch(fetchRequest)
        return savedRestaurants
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryItem", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = categories[indexPath.row].categories.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row].categories
        performSegue(withIdentifier: "restaurantCategoryList", sender: self)
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantCategoryList" {
            if let viewController = segue.destination as? CategoryRestaurantsTableViewController {
                if let categoryId = selectedCategory?.id,
                   let categoryName = selectedCategory?.name {
                    viewController.categoryId = categoryId
                    viewController.categoryName = categoryName
                } else {
                    if let savedRestaurants = savedRestaurants {
                        viewController.restaurants = savedRestaurants
                    }
                }
            }
        }
    }
    

}

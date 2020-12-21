//
//  RestaurantViewController.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/17/20.
//

import UIKit
import MapKit
import CoreData

class RestaurantViewController: UIViewController {

    var restaurant: Restaurant!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var highlightsTableView: UITableView!
    @IBOutlet weak var locationMapView: MKMapView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightsTableView.dataSource = self
        navigationItem.title = restaurant.name
        let savedRestaurants = fetchRequestSetup()
        if let savedRestaurantsCount = savedRestaurants?.count {
            if savedRestaurantsCount == 0 {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: UIBarButtonItem.Style(rawValue: 1)!, target: self, action: #selector(save))
            }
        }
        configure(with: restaurant)
    }
    
    @objc func save() {
        let newRestaurant = LocalRestaurants(context: context )
        newRestaurant.allReviewsCount = Int64(restaurant.allReviewsCount)
        newRestaurant.currency = restaurant.currency
        newRestaurant.featuredImage = restaurant.featuredImage
        newRestaurant.highlights = restaurant.highlights
        newRestaurant.id = restaurant.id
        newRestaurant.latitude = restaurant.location.latitude!
        newRestaurant.longitude = restaurant.location.longitude!
        newRestaurant.menuUrl = restaurant.menuUrl
        newRestaurant.photosUrl = restaurant.photosUrl
        newRestaurant.name = restaurant.name
        newRestaurant.priceRange = Int64(restaurant.priceRange)
        newRestaurant.rating = restaurant.userRating.ratingObj.title.text
        newRestaurant.timings = restaurant.timings
        newRestaurant.address = restaurant.location.address
        do {
            try context.save()
            navigationItem.rightBarButtonItem?.isEnabled = false
        } catch {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "An error occured", message: error.localizedDescription , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func fetchRequestSetup() -> [LocalRestaurants]? {
        let fetchRequest: NSFetchRequest<LocalRestaurants> = LocalRestaurants.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", restaurant.id)
        fetchRequest.predicate = predicate
        let savedRestaurants = try? context.fetch(fetchRequest)
        return savedRestaurants
    }
    
    func configure(with restaurant: Restaurant) {
        var data: Data?
        if restaurant.featuredImage.count == 0 {
            data = try? Data(contentsOf: URL(string: "https://hazelwood-dental.com/wp-content/themes/hazelwood/images/no-image-found-360x250.png" )!)
        } else {
            data = try? Data(contentsOf: URL(string: restaurant.featuredImage)!)
        }
        imageView.image = UIImage(data: data!)
        rating.text = restaurant.userRating.ratingObj.title.text + " / 5.0 "
        price.text = restaurant.currency + String(restaurant.priceRange)
        timing.text = restaurant.timings
        reviews.text = String(restaurant.allReviewsCount) + " Reviews"
        
        // Map Setup
        if let latitude = Double(restaurant.location.latitude!),
           let longitude = Double(restaurant.location.longitude!)
           {
            let location = CLLocation(latitude: latitude , longitude: longitude )
            let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
            locationMapView.setRegion(locationMapView.regionThatFits(region), animated: true)
            let annotation = MKPointAnnotation();
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude )
            annotation.title = restaurant.location.address
            locationMapView.addAnnotation(annotation)
        }
    }
    
    
    @IBAction func viewMenus(_ sender: UIButton) {
        if let url = URL(string: (restaurant.menuUrl) ) {
            let canOpen = UIApplication.shared.canOpenURL(url)
            if canOpen {
                UIApplication.shared.open(url) { (_) in
                    print("URL opened success")
                }
            }
        }
    }
    
    
    @IBAction func viewPhotos(_ sender: UIButton) {
        if let url = URL(string: (restaurant.photosUrl) ) {
            let canOpen = UIApplication.shared.canOpenURL(url)
            if canOpen {
                UIApplication.shared.open(url) { (_) in
                    print("URL opened success")
                }
            }
        }
    }
    

}

extension RestaurantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.highlights.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)
       
       // Configure the cell’s contents.
        cell.textLabel!.text = restaurant.highlights[indexPath.row]
           
       return cell
    }
}

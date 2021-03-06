//
//  CollectionRestaurantsTableViewController.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/17/20.
//

import UIKit

class CollectionRestaurantsTableViewController: UITableViewController {
    
    var restaurants = [Restaurants]()
    var collectionId: Int?
    var collectionName: String?
    var indicator = UIActivityIndicatorView()
    var selectedRestaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = collectionName
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        
        APIClient.GetCollectionRestaurant(collectionId: collectionId!) { (response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "An error occured", message: error!.localizedDescription , preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }

            guard let response = response else { return }

            DispatchQueue.main.async {
                self.restaurants = response.restaurants
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = restaurants[indexPath.row].restaurant

        // Configure the cell...
        cell.configure(with: restaurant)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = restaurants[indexPath.row].restaurant
        performSegue(withIdentifier: "restaurantView", sender: self)
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantView" {
            if let restaurantVC = segue.destination as? RestaurantViewController {
                restaurantVC.restaurant = selectedRestaurant
            }
        }
    }
    

}

//
//  CollectionsTableViewController.swift
//  ZomatoRestaurants
//
//  Created by Tunde Ola on 12/16/20.
//

import UIKit

class CollectionsTableViewController: UITableViewController {
    
    var collections = [Collections]()
    var selectedCollection: Collection?
    var indicator = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title  = "Collections"
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        APIClient.GetRestaurants() { (result, error) in
            if error != nil {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "An error occured", message: error!.localizedDescription , preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
                return
            }
            
            guard let result = result else { return}
            
            DispatchQueue.main.async {
                self.collections = result
                
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        // text to share
        let text = "This is some text that I want to share."

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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
        return collections.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionItem", for: indexPath) as! CollectionTableViewCell

        // Configure the cell...
        cell.configure(with: collections[indexPath.row].collection! )

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollection = collections[indexPath.row].collection
        performSegue(withIdentifier: "collectionRestaurantList", sender: self)
    }

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionRestaurantList" {
            if let viewController = segue.destination as? CollectionRestaurantsTableViewController {
                viewController.collectionId = selectedCollection?.collectionId
                viewController.collectionName = selectedCollection?.title
            }
        }
    }


}

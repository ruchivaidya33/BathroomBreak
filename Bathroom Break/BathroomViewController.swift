//
//  BathroomViewController.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/29/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MapKit

protocol BathroomViewControllerDelegate : class {
    func locationsPickedLocation(controller: BathroomViewController, latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}


class BathroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    

    var bathrooms = [PFObject]()
    var results: NSArray = []

    let CLIENT_ID = "QA1L0Z0ZNA2QVEEDHFPQWK0I5F1DE3GPLSNW4BZEBGJXUCFL"
    let CLIENT_SECRET = "W2AOE1TYC4MHK5SZYOUGX0J3LVRALMPB4CXT3ZH21ZCPUMCU"

    @IBOutlet weak var tableView: UITableView!
    weak var delegate : BathroomViewControllerDelegate!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 173
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Bathrooms")
        
        query.findObjectsInBackground { (bathrooms, error) in
            if bathrooms != nil {
                self.bathrooms = bathrooms!
                self.tableView.reloadData()
            }
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bathrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BathroomCell") as! BathroomCell

        let bathroom = bathrooms[indexPath.row]

        let imageFile = bathroom["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.bathroomImage.af_setImage(withURL: url)
        cell.locationLabel.text = bathroom["location"] as! String
        cell.overallRatingLabel.text = String(bathroom["rating"] as! Float)

        //cell.numberOfReviewsLabel.text = String(bathroom. as! Float)
        cell.bathroomIDLabel.text = bathroom.objectId

        return cell

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:BathroomCell = tableView.cellForRow(at: indexPath) as! BathroomCell
        UserDefaults.standard.set(cell.bathroomIDLabel.text, forKey: "bathroomID")
        //performSegue(withIdentifier: "ToReviews", sender: self)
        
        let venue = results[(indexPath as NSIndexPath).row] as! NSDictionary
        
        let lat = venue.value(forKeyPath: "location.lat") as! NSNumber
        let lng = venue.value(forKeyPath: "location.lng") as! NSNumber
        
        let latString = "\(lat)"
        let lngString = "\(lng)"
        
        print(latString + " " + lngString)
        delegate.locationsPickedLocation(controller: self, latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
        
        // Return to the PhotoMapViewController
        navigationController?.popViewController(animated: true)

    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        fetchLocations(newText)
        
        return true
    }

    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchLocations(_ query: String, near: String = "San Francisco") {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20141020&near=\(near),CA&query=\(query)"
        
        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let request = URLRequest(url: url)
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,
                                                         completionHandler: { (dataOrNil, response, error) in
                                                            if let data = dataOrNil {
                                                                if let responseDictionary = try! JSONSerialization.jsonObject(
                                                                    with: data, options:[]) as? NSDictionary {
                                                                    NSLog("response: \(responseDictionary)")
                                                                    self.results = (responseDictionary.value(forKeyPath: "response.venues") as! NSArray)
                                                                    self.tableView.reloadData()
                                                                    
                                                                }
                                                            }
        });
        task.resume()
    }


}

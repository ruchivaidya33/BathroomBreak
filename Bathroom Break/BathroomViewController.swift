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

class BathroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    var bathrooms = [PFObject]()

    @IBOutlet weak var tableView: UITableView!
    
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


        let cell = tableView.dequeueReusableCell(withIdentifier: "BathroomCell") as! BathroomCell
        let bathroom = bathrooms[indexPath.row]

        print("selected \(indexPath.row)")

        //performSegue(withIdentifier: "ToReviews", sender: self)

    }

    
    
//    func didSelect(indexPath: NSIndexPath) {
//        performSegue(withIdentifier: "ToReviews", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//        let bathroom = bathrooms[indexPath.row]
//
//        let reviewsViewController = segue.destination as! ReviewsViewController
//
//        //reviewsViewController.bathroom = bathroom
//
//    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

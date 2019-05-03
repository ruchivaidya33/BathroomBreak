//
//  ReviewsViewController.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/24/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bathroomName: UILabel!
    @IBOutlet weak var bathroomRatingLabel: UILabel!
    @IBOutlet weak var bathroomImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var reviews = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        let review = reviews[indexPath.row]
        let user = review["author"] as! PFUser
        cell.nameLabel.text = user.username as! String
        cell.contentLabel.text = review["content"] as! String
        
        
//        let imageFile = review["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//        cell.bathroomImageView.af_setImage(withURL: url)
        
        
        return cell
    }
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        tableView.rowHeight = 180

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Bathrooms")
        let newID = UserDefaults.standard.string(forKey: "bathroomID")
        query.getObjectInBackground(withId: newID!) { (bathroom: PFObject?, error: Error?) in
            if let error = error {
                //The query returned an error
                print(error.localizedDescription)
            } else {
                //The object has been retrieved
                self.bathroomName.text = bathroom!["location"] as! String
                //self.bathroomID.text = bathroom?.objectId
                self.bathroomRatingLabel.text = String(bathroom!["rating"] as! Int)
                let imageFile = bathroom!["image"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                self.bathroomImage.af_setImage(withURL: url)
                let reviewQuery = PFQuery(className: "Reviews")
                reviewQuery.whereKey("bathroomID", equalTo: bathroom?.objectId)
                reviewQuery.includeKeys(["author", "content"])
                reviewQuery.findObjectsInBackground{(reviews:[PFObject]?, error) in
                    self.reviews = reviews!
                    self.tableView.reloadData()

                }
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

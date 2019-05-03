//
//  MapViewController.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/22/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBAction func onPlusClick(_ sender: Any) {
        self.performSegue(withIdentifier: "newBathroomSegue", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

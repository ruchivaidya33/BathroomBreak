//
//  SettingsViewController.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/18/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBAction func onLogOutClick(_ sender: Any) {
        PFUser.logOut()
        let main =  UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
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

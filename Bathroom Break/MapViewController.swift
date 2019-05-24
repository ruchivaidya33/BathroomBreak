//
//  MapViewController.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/22/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, BathroomViewControllerDelegate {

    var pickedImage: UIImage!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func onPlusClick(_ sender: Any) {
        self.performSegue(withIdentifier: "newBathroomSegue", sender: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        mapView.setRegion(region, animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationsPickedLocation(controller: BathroomViewController, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("location picked")
        
        //This is how you make pins in MapKit
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = locationCoordinate
        annotation.title = String(describing: latitude)
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        }
        
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        // Add the image you stored from the image picker
        imageView.image = pickedImage
        
        return annotationView
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        let locationsViewController = segue.destination as! BathroomViewController
//        locationsViewController.delegate = self
//    }
    
//    @IBAction func onCameraButton(_ sender: Any) {
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            print("Camera is available 📸")
//            vc.sourceType = .camera
//        } else {
//            print("Camera 🚫 available so we will use photo library instead")
//            vc.sourceType = .photoLibrary
//        }
//
//        self.present(vc, animated: true, completion: nil)
//
//    }
}
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        //let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
//
//        // Do something with the images (based on your use case)
//        pickedImage = editedImage
//
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismiss(animated: true) {
//            self.performSegue(withIdentifier: "tagSegue", sender: nil)
//        }
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


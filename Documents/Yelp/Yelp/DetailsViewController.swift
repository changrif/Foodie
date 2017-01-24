//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Chandler Griffin on 1/15/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var resultMapLocation: MKMapView!
    var locationManager : CLLocationManager!
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.tintColor = UIColor.white
        if(business.imageURL != nil)    {
        thumbImageView.setImageWith(business.imageURL!)
            thumbImageView.layer.cornerRadius = 5
            thumbImageView.clipsToBounds = true
        }
        nameLabel.text = business.name
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        distanceLabel.text = business.distance
        reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
        addressLabel.text = business.address
        categoriesLabel.text = business.categories
        if(business.ratingImageURL != nil)    {
            ratingsImageView.setImageWith(business.ratingImageURL!)
        }
        
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        addAnnotationAtAddress(address: addressLabel.text!, title: nameLabel.text!)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            resultMapLocation.setRegion(region, animated: false)
        }
    }
    
    // add an annotation with an address: String
    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    self.resultMapLocation.addAnnotation(annotation)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

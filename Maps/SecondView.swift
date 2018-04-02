//
//  SecondView.swift
//  MapApp
//
//  Created by Luã Enrique on 02/04/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit
import MapKit

class SecondView: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    var stringLatitude = ""
    var stringLongitude = ""
    var stringAnnotations = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(stringLatitude)!, longitude: Double(stringLongitude)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        myMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Simple Annotation"
        annotation.subtitle = stringAnnotations
        myMap.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

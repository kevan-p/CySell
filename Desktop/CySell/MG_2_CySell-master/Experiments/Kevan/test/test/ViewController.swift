//
//  ViewController.swift
//  test
//
//  Created by Kevan Patel on 9/7/18.
//  Copyright © 2018 Kevan Patel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBAction func directionView(_ sender: Any) {
        let lat:CLLocationDegrees = 42.026132 //Latitude of Location, Curtiss Hall
        let lon:CLLocationDegrees = -93.644824//Longitude of Location, Curtiss Hall
        //To change this, we woud have to make user select marker on map, maybe even name it, and change variables here
        
        let distanceBetween:CLLocationDistance = 1000; //dummy variable for cordsSpan to work
        //let latitudeMeters:CLLocationDistance = ???
        //let longitudeMeters:CLLocationDistance = ??? need to figure these out and put them in MKCoordinateRegionMakeWithDistance(cords, latitudeMeters, longitudeMeters)
        let cords = CLLocationCoordinate2DMake(lat, lon)//Formats a latitude and longitude value into a coordinate data structure format.
        let cordsSpan = MKCoordinateRegionMakeWithDistance(cords, distanceBetween, distanceBetween)//Creates a new MKCoordinateRegion from the specified coordinate and distance values.
        let launcher = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: cordsSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: cordsSpan.span)] //The coordinate value on which to center the map, in this case it's the middle of the span of the two markers
        
        let endMarker = MKPlacemark(coordinate: cords)//place ending marker at meeting location
        let mapItem = MKMapItem(placemark: endMarker)//adds item to map, which is marker
        mapItem.name = "Meeting Location" //name of marker
        mapItem.openInMaps(launchOptions: launcher) //open the marker in maps after pressing button, view is in middle of span of current location and end marker
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


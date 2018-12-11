//
//  MapView.swift
//  Frontend
//
//  Created by Kevan Patel on 9/23/18.
//  Copyright © 2018 Mitchell Knoth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

/// This is a class view that allows the user
/// to use and view the map for meeting locations.

class MapView: UIViewController {
    
    /// MKMapView of view controller in storyboard
    @IBOutlet weak var mapView: MKMapView!
    /// label of address that is changed as center of map is changed
    @IBOutlet weak var addressView: UILabel!
    /// button to be pressed to draw polyline of directions from current location to marker
    @IBOutlet weak var directionsButton: UIButton!
    /// send marker information to database
    @IBOutlet weak var markerButton: UIButton!
    
    /// location manager for current location
    let manager = CLLocationManager()
    /// how far map is zoomed out
    let regionMeters: Double = 3000
    /// previous location to be stored when directions changes center of map to fit directions request region
    var prevLocation: CLLocation?
    
    /// longitude of coordinate to be sent into database
    var longitudeDB = 0.0
    /// latitude of coordinate to be sent into database
    var latitudeDB  = 0.0
    
    var markerLocation: CLLocation!
    
    var address = ""
    
    ///geoLocation coordinate used in reverse geoLocation
    let geoLocation = CLGeocoder()
    /// Array of direction requests
    var arrayDirections: [MKDirections] = []
    
    /// Sets up Location Manager to get current location and checks if application has permission to access current location
    override func viewDidLoad() {
        super.viewDidLoad()
        checkServices()
    }
    
    /// Checks if application is using up too much memory, can crash application
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Sets location manager delegate and makes current location accuracy the best possible one
    func setupManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Sets center of map as current location
    func centerLocation() {
        if let location = manager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    /// Gets coordinates of center of map, which is the marker
    ///
    /// - Parameter mapView: MKMapView variable for embedded map
    /// - Returns: center location coordinates
    func getCenter(for mapView: MKMapView) -> CLLocation {
        let lat = mapView.centerCoordinate.latitude
        let lon = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: lat, longitude: lon)
    }
    
    /// Checks if location services are enabled, if they are sets up location manager and checks permissions
    func checkServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        }
        else {
            print("CHECK PERMISSIONS")
        }
    }
    
    /// Tracks and updates user's current location
    func trackLocation() {
        mapView.showsUserLocation = true
        centerLocation()
        manager.startUpdatingLocation()
        prevLocation = getCenter(for: mapView)
    }
    
    /// Calculates directions from current location to placed marker
    func Directions() {
        guard let location = manager.location?.coordinate else {
            print("LOCATION GUARD")
            return
        }
        
        let directionsRequest = getDirections(from: location)
        let directionObject   = MKDirections(request: directionsRequest)
        resetMap(withNew: directionObject)
        
        directionObject.calculate { [unowned self] (response, error) in
            guard let response = response else {
                print("RESPONSE GUARD")
                return
            }
            
            for route in response.routes {
                //let navigationSteps = route.steps USE LATER FOR NAVIGATION (USE TABLE VIEW)
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    /// Adds marker annotation on map with long press
    ///
    /// - Parameter sender: Recognizes of user long presses
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mapView)
        let locationCoordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "Meeting Location"
        annotation.subtitle = "Location of Buyer/Seller Meeting"
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        longitudeDB = locationCoordinate.longitude
        latitudeDB = locationCoordinate.latitude
        
        markerLocation = CLLocation(latitude: latitudeDB, longitude: longitudeDB)
        
        self.mapView.addAnnotation(annotation)
        
        CLGeocoder().reverseGeocodeLocation(markerLocation) { (placemark, error) in
            if error != nil
            {
                print("ERROR")
            }
            else
            {
                if let place = placemark?[0]
                {
                    let streetNum = place.subThoroughfare ?? ""
                    let streetName = place.thoroughfare ?? ""
                    let zipCode = place.postalCode ?? ""
                    
                    DispatchQueue.main.async {
                        self.addressView.text = "\(streetNum) \(streetName) \(zipCode)"
                    }
                }
            }
            
        }
    }

    /// Gets directions from current location to marker with button press as a polyline
    ///
    /// - Parameter sender: Recognizes of directions button is pressed
    @IBAction func directionsButton(_ sender: UIButton) {
        //Directions()
        print("POLYLINE BUG")
    }
    
    func editInformation() {
        self.address = addressView.text!
        
        performSegue(withIdentifier: "map", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var viewControl = segue.destination as! ItemPostViewController
        
        viewControl.finalAddress = self.address
    }
    
    /// Sends marker to database
    ///
    /// - Parameter sender: Recognizes if Send Marker button is pressed
    @IBAction func sendMarker(_ sender: UIButton) {
        //saveMarkerDB()
        editInformation()
    }

    /// Resets directions and polylines if new directions request is made
    ///
    /// - Parameter directions: Recognizes if new direction request is made
    func resetMap(withNew directions: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        arrayDirections.append(directions)
        let _ = arrayDirections.map {
            $0.cancel()
        }
    }
    
    /// Makes and returns direction request from current location to marker (center location of map via reverse geolocation)
    ///
    /// - Parameter coordinate: latitude and longitude coordinates
    /// - Returns: returns a directions request with directions information
    func getDirections(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destination          = getCenter(for: mapView).coordinate
        let startPlacemark       = MKPlacemark(coordinate: coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let directionsRequest                     = MKDirections.Request()
        directionsRequest.source                  = MKMapItem(placemark: startPlacemark)
        directionsRequest.destination             = MKMapItem(placemark: destinationPlacemark)
        directionsRequest.requestsAlternateRoutes = true //MIGHT CHANGE
        directionsRequest.transportType           = .automobile
        
        return directionsRequest
    }
    
    /// Checks permissions given by user, if a user doesn't have permissions the current location function of the map will not work
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            trackLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .restricted:
            break
        }
    }
    
}

// MARK: - CLLocationManagerDelegate extension of MapView
extension MapView: CLLocationManagerDelegate {
    
    /// Sets region of map (what the user currently sees) zoomed in on current location
    ///
    /// - Parameters:
    ///   - manager: location manager
    ///   - locations: current location coordinates
    func manager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            print("CURRENTLOCATION GUARD")
            return
        }
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let regionCoordinate = MKCoordinateRegion.init(center: centerCoordinate, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
        mapView.setRegion(regionCoordinate, animated: true)
    }
    
    /// Checks if user has given app permission to access current location so location manager can grab it
    ///
    /// - Parameters:
    ///   - manager: location manager
    ///   - status: authorization status of current location
    func manager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}

// MARK: - MKMapViewDelegate extension of MapView
extension MapView: MKMapViewDelegate {
    /// Renders polyline for directions in MKMapView of view controller in storyboard
    ///
    /// - Parameters:
    ///   - mapView: MKMapView of view controller in storyboard
    ///   - overlay: polyline overlay which is added in Directions()
    /// - Returns: rendered polyline with settings
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        render.lineWidth = 3.0
        //LINEWIDTH BUGGING OUT?
        return render
    }
}


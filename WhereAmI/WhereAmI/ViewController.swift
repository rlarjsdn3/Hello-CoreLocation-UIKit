//
//  ViewController.swift
//  WhereAmI
//
//  Created by 김건우 on 9/18/25.
//

import MapKit
import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationButton: UIBarButtonItem!
    
    private let locationManager = AsyncLocationManager()
    
    private var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationUpdates()
    }

    private func locationUpdates() {
        Task {
            do {
                for try await location in locationManager.locationUpdates(updatesImmediately: false) {
                    print("현재 위치: \(location.coordinate.latitude) / \(location.coordinate.longitude)")
                    print("속도: \(location.speed)m/s")
                    print("방위: \(location.course)°")
                    print("고도: \(location.altitude)m")
                    print("--------------------------")
                    setMKMapViewRegion(with: location)
                }
            } catch {
                print("Handle error here..")
            }
        }
    }
    
    @IBAction func currentLocationButtonTapped(_ sender: Any) {
        if locationManager.isUpdatingLocation {
            let image = UIImage(systemName: "location.circle.fill")!
            locationButton.setSymbolImage(image, contentTransition: .replace)
            locationManager.stopLocationUpdates()
            mapView.showsUserLocation = false
        } else {
            let image = UIImage(systemName: "location.slash.circle.fill")!
            locationButton.setSymbolImage(image, contentTransition: .replace)
            locationManager.startLocationUpdates()
            mapView.showsUserLocation = true
        }
    }
}

fileprivate extension ViewController {
    
    func setMKMapViewRegion(with location: CLLocation) {
        guard CLLocationCoordinate2DIsValid(location.coordinate)
        else { return  }
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        regionDidChangeAnimated animated: Bool
    ) {
    }
}

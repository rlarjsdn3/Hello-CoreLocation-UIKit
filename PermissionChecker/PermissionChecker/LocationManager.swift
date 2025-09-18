//
//  LocationManager.swift
//  PermissionChecker
//
//  Created by 김건우 on 9/17/25.
//

import CoreLocation
import Combine
import Foundation

final class LocationManager: NSObject {

    private let locationManager = CLLocationManager()

    private var isUpdatingLocation: Bool = false

    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func updatingLocation() -> Bool {
        isUpdatingLocation
        ? stopUpdatingLocation()
        : startUpdatingLocation()
        return isUpdatingLocation
    }

    func startUpdatingLocation() {
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus

        if manager.authorizationStatus == .notDetermined {
            requestWhenInUseAuthorization()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        self.currentLocation = location
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        print("didFailureWithError: \(error.localizedDescription)")
    }
}


extension CLAuthorizationStatus: @retroactive CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:        return "notDeterminded"
        case .restricted:           return "restricted"
        case .denied:               return "denied"
        case .authorizedAlways:     return "authorizedAlways"
        case .authorizedWhenInUse:  return "authorizedWhenInUse"
        default:                    return "unknown"
        }
    }
}

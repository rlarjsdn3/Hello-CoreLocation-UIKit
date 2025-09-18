//
//  AsyncLocationManager.swift
//  WhereAmI
//
//  Created by 김건우 on 9/18/25.
//

import CoreLocation
import Foundation

final class AsyncLocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var isUpdatingLocation = false
    
    private var locationContinuation: AsyncThrowingStream<CLLocation, any Error>.Continuation?
    var locationStream: AsyncThrowingStream<CLLocation, any Error>?
    
    private var authorizationContinuation: AsyncStream<CLAuthorizationStatus>.Continuation?
    var authorizationStream: AsyncStream<CLAuthorizationStatus>?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }

    
    // MARK: - Location Updates
    
    func locationUpdates(updatesImmediately: Bool = true) -> AsyncThrowingStream<CLLocation, any Error> {
        self.locationStream = nil
        self.locationContinuation = nil
        
        let locStream = AsyncThrowingStream<CLLocation, any Error> { continuation in
            continuation.onTermination = { @Sendable _ in
                Task { @MainActor in
                    self.isUpdatingLocation = false
                    self.locationStream = nil
                    self.locationContinuation = nil
                }
            }
            self.locationContinuation = continuation
        }
        
        self.locationStream = locStream
        
        if updatesImmediately { startLocationUpdates() }
        
        return locStream
    }
    
    func startLocationUpdates() {
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
    }
    
    
    // MARKL - Authorization Updates
    
    func authorizationUpdates() -> AsyncStream<CLAuthorizationStatus> {
        authorizationStream = nil
        authorizationContinuation = nil
        
        let authStream = AsyncStream<CLAuthorizationStatus> { continuation in
            continuation.onTermination = { @Sendable _ in
                Task { @MainActor in
                    self.authorizationStream = nil
                    self.authorizationContinuation = nil
                }
            }
            self.authorizationContinuation = continuation
        }
        self.authorizationStream = authStream
        return authStream
    }
    
    private func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

}

extension AsyncLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        
        switch authorizationStatus {
        case .restricted, .denied:
            stopLocationUpdates()
            
        case .notDetermined:
            requestWhenInUseAuthorization()
            
        default:
            break
        }
      
        authorizationContinuation?.yield(authorizationStatus)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        locationContinuation?.yield(with: .success(location))
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        locationContinuation?.yield(with: .failure(error))
    }
}

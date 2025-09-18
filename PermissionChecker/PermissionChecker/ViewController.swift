//
//  ViewController.swift
//  PermissionChecker
//
//  Created by 김건우 on 9/16/25.
//

import CoreLocation
import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var updateLocationButton: UIButton!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var authorizationStatusLabel: UILabel!

    private let locationManager = LocationManager()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    private func bind() {
        locationManager.$authorizationStatus
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] auth in self?.authorizationStatusLabel.text = "\(auth)" }
            .store(in: &cancellables)

        locationManager.$currentLocation
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in self?.refreshLocation(location) }
            .store(in: &cancellables)
    }

    @IBAction func updatingLocationButtonTapped(_ sender: Any) {
        locationManager.updatingLocation()
        ? { updateLocationButton.setTitle("위치 추적 중지", for: .normal) }()
        : { updateLocationButton.setTitle("위치 추적 시작", for: .normal) }()
    }

    private func refreshLocation(_ location: CLLocation?) {
        guard let location = location else { return }
        latitudeLabel.text = "\(location.coordinate.latitude)"
        longitudeLabel.text = "\(location.coordinate.longitude)"
    }
}

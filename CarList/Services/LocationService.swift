//
//  LocationService.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import CoreLocation

enum LocationError: Swift.Error {
    case status
    var localizedDescription: String {
        switch self {
        case .status: return "Please allow location tracking in settings"
        }
    }
}

struct Location {
    let latitude: Double
    let longitude: Double
    static let zero = Location(latitude: 0.0, longitude: 0.0)
    
    init(with clLocation: CLLocation) {
        self.latitude = clLocation.coordinate.latitude
        self.longitude = clLocation.coordinate.longitude
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

typealias LocationUpdate = (Location) -> Void

class LocationService: NSObject {
    
    // MARK: - Init -
    init(with locationUpdate: LocationUpdate? = nil) {
        super.init()
        self.locationUpdate = locationUpdate
        setup(locationManager)
    }
    
    // MARK: - Public -
    var currentLocation: Location {
        do {
            return try getcurrentLocation()
        } catch (let error) {
            AlertController.show(with: error.localizedDescription,
                                 actions: [AlertAction.settings.default, AlertAction.cancel.default])
            return Location.zero
        }
    }
    
    var locationUpdate: LocationUpdate?
    
    // MARK: - Private -
    private static var locationManager: CLLocationManager?
    private var locationManager: CLLocationManager {
        if let locationManager = LocationService.locationManager {
            return locationManager
        } else {
            let locationManager = CLLocationManager()
            LocationService.locationManager = locationManager
            return locationManager
        }
    }
    
    private func setup(_ locationManager: CLLocationManager) {
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = false;
        locationManager.allowDeferredLocationUpdates(untilTraveled: 10000, timeout: 3600)
    }
    
    private func getcurrentLocation() throws -> Location {
        guard authorized else {
            throw LocationError.status
        }
        locationManager.requestLocation()
        if let location = locationManager.location {
            return Location(with: location)
        } else {
            return Location.zero //TODO: save and fetch last location
        }
    }
    
    private var authorized: Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: return true
        default: return false
        }
    }

}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last { locationUpdate?(Location(with: location)) }
    }
    
}

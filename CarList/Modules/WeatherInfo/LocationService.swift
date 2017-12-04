//
//  LocationService.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

extension LocationService: LocationProvider {}

enum LocationError: Swift.Error {
    case status
    var localizedDescription: String {
        switch self {
        case .status: return R.string.localizable.errorLocationStatus()
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

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

class LocationService {
    
    // MARK: - Public -
    private (set) var authorized: Driver<Bool>
    private (set) var location: Driver<Location>
    
    var isAuthorized: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    // MARK: - Init -
    
    init() {
        self.authorized = Observable.deferred { [weak locationManager] in
            let status = CLLocationManager.authorizationStatus()
            guard let locationManager = locationManager else {
                return Observable.just(status)
            }
            return locationManager
                .rx.didChangeAuthorizationStatus
                .startWith(status)
            }
            .asDriver(onErrorJustReturn: CLAuthorizationStatus.notDetermined)
            .map {
                switch $0 {
                case .authorizedWhenInUse: return true
                default: return false
                }
        }
        self.location = locationManager.rx.didUpdateLocations
            .asDriver(onErrorRecover: { error in
                if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                    AlertController.show(with: LocationError.status.localizedDescription,
                                         actions: [AlertAction.settings.default, AlertAction.cancel.default])
                }
                print(error)
                return Driver.just([])
            })
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.just(CLLocation(latitude: 0, longitude: 0))
            }
            .map { Location(with: $0) }
        setup(locationManager)
    }
    
    // MARK: - Private -
    private let locationManager = CLLocationManager()
    
    private func setup(_ locationManager: CLLocationManager) {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = false;
        locationManager.allowDeferredLocationUpdates(untilTraveled: 10000, timeout: 3600)
        
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

}

//
//  ViewController.swift
//  CoreLocationExample
//
//  Created by 성준 on 2022/02/14.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationAuthorization()
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension ViewController: CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager,
         didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatusSwitch(with: manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 14.0부터
        locationStatusSwitch(with: manager)
    }
    
    func locationStatusSwitch(with locationManager: CLLocationManager) {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print(".authorizedAlways, .authorizedWhenInUse")
            
        case .authorized:
            break
        @unknown default:
            break
        }
    }
}


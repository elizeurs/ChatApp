//
//  ChatMapVC.swift
//  ChatApp
//
//  Created by Elizeu RS on 29/08/23.
//

import UIKit
import GoogleMaps

class ChatMapVC: UIViewController {
  
  // MARK: - Properties
  
  private let mapView = GMSMapView()
  private var location: CLLocationCoordinate2D?
  private lazy var marker = GMSMarker()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureMapView()
  }
  

  // MARK: - Helpers
  
  private func configureUI() {
    title = "Select Location"
    
    view.addSubview(mapView)
    view.backgroundColor = .white
    mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
  }
  
  private func configureMapView() {
    FLocationManager.shared.start { info in
      self.location = CLLocationCoordinate2DMake(info.latitude ?? 0.0, info.longitude ?? 00)
      self.mapView.delegate = self
      self.mapView.isMyLocationEnabled = true
      self.mapView.settings.myLocationButton = true
      
      guard let location = self.location else { return }
      self.updateCamera(location: location)
      FLocationManager.shared.stop()
    }
  }
  
  func updateCamera(location: CLLocationCoordinate2D) {
    self.location = location
    self.mapView.camera = GMSCameraPosition(target: location, zoom: 15)
    self.mapView.animate(toLocation: location)
    
    // TODO: - Add marker
    marker.map = nil
    marker = GMSMarker(position: location)
    marker.map = mapView
  }

}

// MARK: - GMSMapViewDelegate
extension ChatMapVC: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
    updateCamera(location: coordinate)
  }
}

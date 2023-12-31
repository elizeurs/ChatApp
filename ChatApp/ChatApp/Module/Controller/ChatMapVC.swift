//
//  ChatMapVC.swift
//  ChatApp
//
//  Created by Elizeu RS on 29/08/23.
//

import UIKit
import GoogleMaps

protocol ChatMapVCDelegate: AnyObject {
  func didTapLocation(lat: String, lng: String)
}

class ChatMapVC: UIViewController {
  
  // MARK: - Properties
  
  weak var delegate: ChatMapVCDelegate?
  
  private let mapView = GMSMapView()
  private var location: CLLocationCoordinate2D?
  private lazy var marker = GMSMarker()
  
  private lazy var sendLocationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send Location", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
    button.tintColor = .white
    button.backgroundColor = .red
    button.setDimensions(height: 50, width: 150)
    button.layer.cornerRadius = 15
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(handleSendLocationButton), for: .touchUpInside)
    return button
  }()
  
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
    
    view.addSubview(sendLocationButton)
    sendLocationButton.centerX(inView: view)
    sendLocationButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
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
  
  @objc func handleSendLocationButton() {
    guard let lat = location?.latitude else { return }
    guard let lng = location?.longitude else { return }
    delegate?.didTapLocation(lat: "\(lat)", lng: "\(lng)")
  }

}

// MARK: - GMSMapViewDelegate
extension ChatMapVC: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
    updateCamera(location: coordinate)
  }
}

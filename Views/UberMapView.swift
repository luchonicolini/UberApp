//
//  UberMapView.swift
//  Uber
//
//  Created by Luciano Nicolini on 27/09/2022.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
        
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = false
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate {
           // print("DEBUG: Selected location in map view \(coordinate)")
            context.coordinator.addAndSelectAnnotation(withCordinate: coordinate)
            
        }
    }
    
    func makeCoordinator() -> MapCordinator {
        return MapCordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        // lifecycle
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            parent.mapView.setRegion(region, animated: true)
        }
        // Helpers
        func addAndSelectAnnotation(withCordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
    }
}



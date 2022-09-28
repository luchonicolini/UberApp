//
//  LocationModelSearch.swift
//  Uber
//
//  Created by Luciano Nicolini on 28/09/2022.
//

import Foundation
import MapKit

class LocationSearchModel: NSObject, ObservableObject {
  
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: String?
    
    private let serachCompleter = MKLocalSearchCompleter()
    var queryFragement: String = "" {
        didSet {
           // print("DEBUG: query fragemnt is \(queryFragement)")
            serachCompleter.queryFragment = queryFragement
        }
    }
    
    override init() {
        super.init()
        serachCompleter.delegate = self
        serachCompleter.queryFragment = queryFragement
    }
    
    func selectLocation(_ location: String) {
        self.selectedLocation = location
        //print("DEBUG: Selected location is \(self.selectedLocation)")
    }
    
}

extension LocationSearchModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results 
    }
}


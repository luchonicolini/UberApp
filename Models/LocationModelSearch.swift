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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    
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
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
           
            print("Debug: Location coordinates \(coordinate)")
            
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler)  {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
}

extension LocationSearchModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results 
    }
}


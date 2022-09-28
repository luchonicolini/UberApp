//
//  UberApp.swift
//  Uber
//
//  Created by Luciano Nicolini on 27/09/2022.
//

import SwiftUI

@main
struct UberApp: App {
    @StateObject var locationViewModel = LocationSearchModel()
 
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}

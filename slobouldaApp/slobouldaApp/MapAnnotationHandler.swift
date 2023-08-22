//
//  MapAnnotationHandler.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 22/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

func handleBoulderAreaTap(at location: LocationAnnotation, regionBinding: Binding<MKCoordinateRegion>) {
    var region = regionBinding.wrappedValue
    let zoomLevel: CLLocationDegrees = 0.1 // Adjust this for the desired zoom level
    region = MKCoordinateRegion(
        center: location.coordinate,
        span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel)
    )
    withAnimation {
        regionBinding.wrappedValue = region
    }
    
    
}

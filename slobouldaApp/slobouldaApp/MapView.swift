//
//  MapView.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 15/08/2023.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit



struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.6690, longitude: 19.6990),
        span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
        // Adjust this for desired zoom level
    )
    
    
    let locations: [Location] = [sampleLocation]

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: locations) { location in
                MapMarker(coordinate: location.coordinate, tint: .blue) // This is the default pin
        }
    }
}


let sampleLocation = Location(coordinate: CLLocationCoordinate2D(latitude: 48.733, longitude: 18.933))

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

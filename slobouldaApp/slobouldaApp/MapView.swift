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


struct Boulder: Codable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let grade: String
    let boulderAreaId: Int?
}

struct BoulderArea: Codable, Identifiable {
    let id: Int
    let name: String
    let boulders: [Boulder]
}

struct LocationAnnotation: Identifiable {
    var id: Int
    var coordinate: CLLocationCoordinate2D
    var isBoulder: Bool
}

struct MapView: View {
    @State private var boulders: [Boulder] = []
    @State private var boulderAreas: [BoulderArea] = []
    @State private var dataLoaded: Bool = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.6690, longitude: 19.6990),
        span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
    )
    var annotations: [LocationAnnotation] {
        var locations: [LocationAnnotation] = []
        
        for area in boulderAreas {
            if let boulder = area.boulders.first {
                locations.append(LocationAnnotation(id: boulder.id, coordinate: CLLocationCoordinate2D(latitude: boulder.latitude, longitude: boulder.longitude), isBoulder: false))
            }
        }
        
        for boulder in boulders {
            locations.append(LocationAnnotation(id: boulder.id, coordinate: CLLocationCoordinate2D(latitude: boulder.latitude, longitude: boulder.longitude), isBoulder: true))
        }
        
        return locations
    }

    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(location.isBoulder ? "boulder" : "boulderArea")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40) // Adjust size as needed
                    .onTapGesture {
                        if !location.isBoulder {
                            handleBoulderAreaTap(at: location, regionBinding: $region)
                            
                        }
                    }
                }
            }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if !dataLoaded {
                loadData(from: "boulder_areas", into: $boulderAreas)
                loadData(from: "boulders?boulderAreaId=0", into: $boulders)
                dataLoaded = true
            }
        }
    }
    
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
    
    

}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

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
    var id = UUID() // This gives each annotation a unique identifier
    var coordinate: CLLocationCoordinate2D
    var isBoulder: Bool
}

struct MapView: View {
    @State private var boulders: [Boulder] = []
    @State private var boulderAreas: [BoulderArea] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.6690, longitude: 19.6990),
        span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
    )

    var body: some View {
         Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(location.isBoulder ? "boulder" : "boulderArea")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45) // Adjust size as needed
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{loadData(from: "boulder_areas", into: $boulderAreas)
                  loadData(from: "boulders?boulderAreaId=0", into: $boulders)
            
        }
    }
    
    var annotations: [LocationAnnotation] {
        var locations: [LocationAnnotation] = []
        
        for area in boulderAreas {
            if let boulder = area.boulders.first {
                locations.append(LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: boulder.latitude, longitude: boulder.longitude), isBoulder: false))
            }
        }
        
        for boulder in boulders {
            locations.append(LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: boulder.latitude, longitude: boulder.longitude), isBoulder: true))
        }
        
        return locations
    }
    
    func loadData<T: Decodable & Identifiable>(from tableEndpoint: String, into binding: Binding<[T]>) {
        guard let url = URL(string: "http://localhost:8080/api/v1/\(tableEndpoint)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let decodedResponse = try? JSONDecoder().decode([T].self, from: data) {
                DispatchQueue.main.async {
                    binding.wrappedValue = decodedResponse
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

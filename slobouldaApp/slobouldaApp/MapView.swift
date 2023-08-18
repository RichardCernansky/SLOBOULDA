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


struct ClimbingSpot: Codable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let grade: String
}


struct MapView: View {
    @State private var spots: [ClimbingSpot] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.6690, longitude: 19.6990),
        span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
    )

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: spots) { spot in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude)) {
                Image("boulder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45) // Adjust size as needed
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "http://localhost:8080/api/v1/boulders") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([ClimbingSpot].self, from: data) {
                    DispatchQueue.main.async {
                        self.spots = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}





struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

//
//  DataLoader.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 22/08/2023.
//

import Foundation
import SwiftUI


//map view loading
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

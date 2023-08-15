//
//  ContentView.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 15/08/2023.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: -18) // This pushes the image up by y
                .edgesIgnoringSafeArea(.all)

            Button {
            } label: {
                Text("Boulder Locator")
                    .foregroundColor(.white) // Set the text color to white
                    .padding()
                    .background(Color(hex: "C91012"))
                    .clipShape(Capsule()) // Apply the capsule shape
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

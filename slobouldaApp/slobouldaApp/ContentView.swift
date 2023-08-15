//
//  ContentView.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("backgroundImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: -18) // This pushes the image up by 50
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

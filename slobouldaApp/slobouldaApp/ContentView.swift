//
//  ContentView.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: -18) // This pushes the image up by y
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(spacing: 20) {
                    NavigationLink(destination: MapView()){
                        CustomButton(title: "Map of boulders")
                    }
                    NavigationLink(destination: FavouritesView()){
                        CustomButton(title: "Favourites")
                    }
                    NavigationLink(destination: ProfileView()){
                        CustomButton(title: "Profile")
                    }
                }
                .padding(.bottom, 300) // Adjust the value to your needs
                
            }
        }
    }
}


struct CustomButton: View {
    let title: String
    
    var backgroundColor: Color = .white
    var foregroundColor: Color = .black
    var buttonWidth: CGFloat = 320  // Specify your desired width here

    var body: some View {
        Text(title)
            .padding()
            .frame(width: buttonWidth) // Set the width here
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .font(Font.custom("OwreKynge", size: 45))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 5)
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


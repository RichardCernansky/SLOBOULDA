//
//  ContentView.swift
//  slobouldaApp
//
//  Created by Richard Čerňanský on 15/08/2023.
//

import SwiftUI

import SwiftUI
import UIKit

struct UIKitBackgroundView: UIViewRepresentable {
    
    func offsetImage(_ image: UIImage, by offset: CGFloat) -> UIImage {
        let newSize = CGSize(width: image.size.width, height: image.size.height + offset)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { context in
            let rect = CGRect(x: 0, y: offset, width: image.size.width, height: image.size.height)
            image.draw(in: rect)
        }
    }

    func makeUIView(context: Context) -> UIImageView {
        guard let originalImage = UIImage(named: "AppIcon") else {
            return UIImageView() // return a blank UIImageView if the image isn't found
        }
        
        let zoomScale: CGFloat = 0.5  // Smaller than 1 will zoom out
        let newSize = CGSize(width: originalImage.size.width * zoomScale, height: originalImage.size.height * zoomScale)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            originalImage.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        let yOffset: CGFloat = 320  // Adjust this value as needed
        let finalImage = offsetImage(resizedImage, by: yOffset)
        
        let imageView = UIImageView(image: finalImage)
        imageView.contentMode = .top // Set to top so that the offset image is shown from its top

        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        // No update code necessary
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            UIKitBackgroundView() // Adjust contentScale as needed
            
            VStack {
                
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  ParallaxPlanetCard
//
//  Created by Amish Tufail on 03/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var valueTransalation: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            // This should be like a transparent image, here it is not because couldnt find one
            Image(.stars)
                .resizable()
                .scaledToFill()
                .frame(width: 250.0, height: 250.0)
            // This is the code that moves the image
                .offset(x: valueTransalation.width / 10, y: valueTransalation.height / 10)
            // Overlay image, like the main image
            Image(.planet)
                .resizable()
                .scaledToFill()
                .frame(width: 250.0, height: 250.0)
            // This is the code that moves the image
                .offset(x: valueTransalation.width / 5, y: valueTransalation.height / 5)
            // This is to give main image like a shadow behind it when we translate
            Circle()
                .fill(.white)
                .frame(width: 50.0, height: 50.0)
                .blur(radius: 50.0)
                .offset(x: -valueTransalation.width / 1.5, y: -valueTransalation.height / 1.5)
        }
        // This is the code that moves the whole image as one
        .offset(x: valueTransalation.width / 10, y: valueTransalation.height / 10)
        .frame(width: 300.0, height: 400.0)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 30.0)) // within this background and clipShape the images will move, that is why they are placed here, and that is also the reason images are set to scaleToFill
        // This is the one that moves the card
        .rotation3DEffect( // Playaround with this as this is the one that makes the card move
            .degrees(isDragging ? 10.0 : 0.0), // when drag, then make the card move in diff axis
            axis: (x: -valueTransalation.height, y: valueTransalation.width, z: 0.0) // They the axis in which that above degree angle should be applied
        )
        // Main Gesture code
        .gesture(
            DragGesture()
                .onChanged({ value in
                    valueTransalation = value.translation
                    isDragging = true
                })
                .onEnded({ value in
                    valueTransalation = .zero
                    isDragging = false
                })
        )
    }
}

#Preview {
    ContentView()
}

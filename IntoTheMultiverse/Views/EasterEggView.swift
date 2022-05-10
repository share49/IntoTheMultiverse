//
//  EasterEggView.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import SwiftUI
import Kingfisher

struct EasterEggView: View {
    
    // MARK: - Properties
    
    @State private var angle: CGFloat = 0
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text(k.EasterEgg.title)
                .font(.title)
            
            KFImage(URL(string: k.EasterEgg.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    angle += k.EasterEgg.rotation
                }
                .rotationEffect(.degrees(angle))
                .animation(.easeIn(duration: k.EasterEgg.rotationDuration), value: angle)
            
            Spacer()
        }
        .navigationTitle("Easter🥚")
        .padding()
    }
}

struct EasterEggView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EasterEggView()
            EasterEggView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityExtraLarge)
                .previewDevice("iPhone SE (3rd generation)")
        }
    }
}

//
//  VisualEffectBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.06.2025.
//

/*
 iOS 17 on;y
 
 Ex.: perform an operation if the text is a certain size
    - if > 200 (gray) -> else red
 Ex.2: animated scroll view
 
Note: if possible use .visualEffect instead of geometry reader -> more performant
 */

import SwiftUI

struct VisualEffectBootcamp: View {
    var body: some View {
        
        // 1. Option (didnt return correct width of Text)
//        GeometryReader { geometry in
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .padding()
//                .background(.red.opacity(0.5))
//                .grayscale(0)
//        }
//        .background(.green)
//        .padding()
        
//        Text("Hello, World! fsdd derferfffref")
//            .padding()
//            .background(.red.opacity(0.5))
//            .visualEffect { content, geometry in
//                content
//                    .grayscale(geometry.size.width >= 200 ? 1 : 0)
//            }
        ScrollView {
            VStack {
                ForEach(0..<100) { index in
                    Rectangle()
                        .frame(width: 300,  height: 300)
                        .frame(maxWidth: .infinity)
                        .background(.brown)
                        .visualEffect { content, geometry in
                            content
                                .offset(x: geometry.frame(in: .global).minY * 0.05)
                        }
                }
            }
        }
    }
}

#Preview {
    VisualEffectBootcamp()
}

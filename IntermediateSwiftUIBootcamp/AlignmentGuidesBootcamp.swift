//
//  AlignmentGuidesBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 07.06.2025.
//

/*
 - When you dont want to use geometry reader (wraps around the element to get the dimensions)
 - Similar to geometry reader takes the width of text view and pushes it forward -> but calls it immediately
 - Ex.: Gets dimensions of the element -> OFFSET BY DIMENSIONS
 - This modifies the background of whole VStack
 */

import SwiftUI

struct AlignmentGuidesBootcamp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(.blue.opacity(0.5))
//                .padding(.leading, -10)
//                .offset(x: -10) // same as above, however VStack is not changing
                .alignmentGuide(.leading) { dimensions in
                    return dimensions.width
                }
            
            Text("This is some other text...")
                .background(.red.opacity(0.5))
        }
        .background(.orange.opacity(0.4))
    }
}

// Show icon only on row 2
struct AlignmentChildView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row(title: "Row 1")
            row(title: "Row 2", showIcon: false)
            row(title: "Row 3")
        }
        .padding(16)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool = true) -> some View {
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
//                .opacity(showIcon ? 1 : 0)  // Super valid way to do it
            
            Text(title)
            
            Spacer()
        }
        .background(.blue.opacity(0.2))
        .alignmentGuide(.leading) { dimensions in
            return showIcon ? 40 : 0
        }
    }
}

#Preview {
//    AlignmentGuidesBootcamp()
    AlignmentChildView()
}

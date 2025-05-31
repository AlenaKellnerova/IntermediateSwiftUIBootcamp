//
//  AccessibilityTextBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 27.05.2025.
//
/*
 1. Try avoid fixed sizes
 2. Turn on Dynamic sizes, start from the bottom
 3. Add Line Limits
 4. Add Minimum Scale Factor
 */


import SwiftUI

struct AccessibilityTextBootcamp: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    // SIZE CATEGORY = all of the text sizes available in in Dynamic Type Settings
    // Range: from .extraSmall .... .accessibilityExtraExtraExtraLarge
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(1..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack {
                            Image(systemName: "heart.fill") // SYSTEM ICONS = by default scaling with font sizes
//                                .font(.headline) // WILL SCALE = dynamic, resizable by default
                                .font(.system(size: 50)) // FIXED SIZE
                                .foregroundStyle(.pink.opacity(0.8))
                            Text("Welcome to my App")
                        }
                        .font(.title)
                        
                        Text("This is a long text that should be read aloud and should wrap")
                            .font(.subheadline)
                            .truncationMode(.tail)  // 1. Where we want the Ellipis
                            .lineLimit(3)    // 2. Great alternative for using fixed height
//                            .minimumScaleFactor(0.8)   // 3. Resize the text DOWN to fit the LINE LIMIT = what percentage of the current font size can the system SCALE DOWN the font to fit this LINE LIMIT // 1 = 100% = system cannot resize any more than 100% of current size
                            .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                    }
//                    .frame(height: 100)
                    .background(.blue.opacity(0.2))
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Accessibility Text")
        }
    }
}

extension ContentSizeCategory {
    
    var customMinScaleFactor : CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        default:
            return 0.6  // the largest ones
        }
    }
    
}

#Preview {
    AccessibilityTextBootcamp()
}

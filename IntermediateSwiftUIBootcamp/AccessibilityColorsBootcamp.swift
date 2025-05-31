//
//  AccessibilityColorsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 31.05.2025.
//

import SwiftUI

/*
 1. Xcode -> Open Developer Tools -> Accessibility Inspector
 2. Window -> Show Contrast Color Calculator
    = Putting Text on Background
    - gives ratio good...bad for accessibility purposes for user to be able to read the text
 - 21: 1 = very high contrast ratio
 */

/*
iPhone Settings -> Accessibility -> Display and Text Size (settings)
    1. Reduce Transparency
        - to improve contrast (reducing transparency & blurs)
    2. Increase Contrast
        - betwen App foreground/ background color
    3. Differenciate Without Color
    4. Smart Invert
 */

struct AccessibilityColorsBootcamp: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        VStack {
            
            Button("Button 1") {
                //
            }
            .foregroundColor(colorSchemeContrast == .increased ? .white : .black)
            .buttonStyle(.borderedProminent)

            Button("Button 2") {
                //
            }
            .foregroundColor(.primary)
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            
            Button("Button 3") {
                //
            }
            .foregroundColor(.primary)
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Button("Button 4") {
                //
            }
            .foregroundColor(differentiateWithoutColor ? .primary : .black)
            .buttonStyle(.borderedProminent)
            .tint(.purple)
        }
        .font(.largeTitle)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reduceTransparency ? Color.black : Color.black.opacity(0.5)) // If user has Reduce Transparency "ON"
        
    }
}

#Preview {
    AccessibilityColorsBootcamp()
}

//
//  AccessibilityVoiceOverBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 31.05.2025.
//

import SwiftUI

/*
 Swipe left = reads the content
 Swipe down = jump from setion to section/heading = default
 */

struct AccessibilityVoiceOverBootcamp: View {
    
    @State private var isOn: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                // SECTION 1
                Section {
                    // System Toggle
                    Toggle("Volume", isOn: $isOn)
                    // Custom Toggle
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isOn ? "ON" : "OFF")
                    }
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        isOn.toggle()
                    }
                    .accessibilityElement(children: .combine)  // groups all elements of this HStack together
                    .accessibilityAddTraits(.isButton) // tells user it is a button
                    .accessibilityValue(isOn ? "Volume on" : "Volume off")  // In case value is not descriptive enough
                    .accessibilityHint("Double tap to toggle volume")  // gives user instruction/ feedback
                    .accessibilityAction {  // Good Practice
                        isOn.toggle()
                    }
                } header: {
                    Text("Preferences")
                }
                
                // SECTION 2
                Section {
                    Button("Favorites") { // VO: "FAVORITES"
                        //
                    }
                    .accessibilityRemoveTraits(.isButton)  // In case we don't want it to serve as button but somt else
                    
                    Button {  // "FAVORITES BUTTON"
                        //
                    } label: {
                        Image(systemName: "heart.fill") // Voice over reads it as "Love Button"
                    }
                    .accessibilityLabel("Favorites")  // New name of the button instead of default love button
                    
                    Text("Favorites")
                        .onTapGesture {
                            //
                        }

                } header: {
                    Text("APPLICATION")
                }
                
                // SECTION 3
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader) // Makes it Heading
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) { x in
                                VStack {
                                    Image("light_background")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                    
                                    Text("Image \(x)")
                                }
                                .onTapGesture {
                                    //
                                }
                                .accessibilityElement(children: .combine)  // Image and Text is one object
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Image number \(x)")
                                .accessibilityHint("Double tap to open")
                                .accessibilityAction {
                                    //
                                }
                            }
                        }
                    }
                    
                }


            }
        }
    }
}

#Preview {
    AccessibilityVoiceOverBootcamp()
}

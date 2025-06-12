//
//  ScrollViewPagingBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 10.06.2025.
//

/*
 Paging Scroll View = Snaps to discrete pages as you swipe -> each page ends up in the center, when swiping
 */

import SwiftUI

struct ScrollViewPagingBootcamp: View {
    
    @State private var scrollPosition: Int? = nil
    
    
    var body: some View {
        
        //MARK: - Horizontal Pager Example
        
        Button {
                scrollPosition = (10..<20).randomElement()!
        } label: {
            Text("Scroll to Position: \(scrollPosition ?? 0)").textCase(.uppercase)
        }

        
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(0..<20) { index in
                    Rectangle()
                        .frame(width: 300, height: 300)
                        .overlay {
                            Text("\(index)").foregroundStyle(.white)
                        }
                        .cornerRadius(10)
                        .padding(10)
                        .containerRelativeFrame(.horizontal, alignment: .center)
                        .id(index)
                        .scrollTransition { content , phase in
                            // content - visual effect
                            // phase - whether cell is on the screen or not
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
//                                .offset(y: phase.isIdentity ? 0 : -300)
                            // phase.isIdentity = cell is fully rendered on the screen
                        }
                    // Transition as the cells appear on the screen of the scroll view
                }
            }
            .padding(.vertical, 100)
        }
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.smooth, value: scrollPosition)
        
        
        
        
        //MARK: - Vertical Pager Example (Tiktok- like)
//        ScrollView {
//            VStack(spacing: 0) {
//                ForEach(0..<100) { index in
//                    Rectangle()
//                        .overlay {
//                            Text("\(index)").foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .containerRelativeFrame(.vertical, alignment: .center) // make sure that the frame of this cell is relative to the entire frame of the scroll view. - only one cell is visible on the screen at the time
//                    // Used together with .paging)
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
////        .scrollTargetBehavior(.viewAligned) // if scroll stops where view is not aligned to the top, it will move to align item automatically
//        .scrollTargetBehavior(.paging)
//        .scrollBounceBehavior(.basedOnSize) // if less than screen size, doesnt bounce
    }
}

#Preview {
    ScrollViewPagingBootcamp()
}

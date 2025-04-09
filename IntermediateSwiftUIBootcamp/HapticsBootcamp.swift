//
//  HapticsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI

class HapticsManager {
    
    static let instance = HapticsManager()  // Singleton
    
    func notification(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(notificationType)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
        
    }
    
}

struct HapticsBootcamp: View {
    var body: some View {
        
        Text("Haptics Bootcamp")
            .padding(.bottom, 50)
        
        
        VStack(spacing: 12) {
            Button("Success") { HapticsManager.instance.notification(notificationType: .success) }
            Button("Warning") { HapticsManager.instance.notification(notificationType: .warning) }
            Button("Error") { HapticsManager.instance.notification(notificationType: .error) }
            Divider()
            Button("Softi") { HapticsManager.instance.impact(style: .soft) }
            Button("Light") { HapticsManager.instance.impact(style: .light) }
            Button("Medium") { HapticsManager.instance.impact(style: .medium) }
            Button("Rigid") { HapticsManager.instance.impact(style: .rigid) }
            Button("Heavy") { HapticsManager.instance.impact(style: .heavy) }
        }
    }
}

#Preview {
    HapticsBootcamp()
}

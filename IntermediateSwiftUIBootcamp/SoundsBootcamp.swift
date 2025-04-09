//
//  SoundsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 08.04.2025.
//

import SwiftUI
import AVKit

// SINGLETON
/*
 
 Manager are used in 2 ways:
 1. They conform to ObservableObject, their instance are marked as @StateObject
        - holds @Published var -> when changed -> View updates automatically
 2. Singleton
 - when there is nothing in manager that changes the view
 = for generic class that can be used in any screen in app
 - initialized inside class - only ONCE
 */

class SoundsManager {
    
     static let instance = SoundsManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(for sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound.  \(error.localizedDescription)")
        }
    }
}

struct SoundsBootcamp: View {
    
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Play Sound 1") {
                SoundsManager.instance.playSound(for: .tada)
            }
            Button("Play Sound 2") {
                SoundsManager.instance.playSound(for: .badum)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}

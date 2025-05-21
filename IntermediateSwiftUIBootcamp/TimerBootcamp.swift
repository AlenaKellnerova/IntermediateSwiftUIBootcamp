//
//  TimerBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 07.05.2025.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect() //Publisher = starts timer as soon as the screen loads
    
    // Current Time
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    // Countdown
//    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    // Countdown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date() // = 24h/ hour
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    
    // Animation Counter
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500
            ).ignoresSafeArea()
            
            VStack {
                Text("Hello, World!")
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                
                Text(timeRemaining)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                HStack(spacing: 15) {
                    Circle()
                        .offset(y: count == 1 ? -20 : 0)
                    Circle()
                        .offset(y: count == 2 ? -20 : 0)
                    Circle()
                        .offset(y: count == 3 ? -20 : 0)
                }
                .frame(width: 150)
                .foregroundStyle(.white)
                
                TabView(selection: $count) {
                    Rectangle()
                        .foregroundStyle(.blue)
                        .tag(1)
                    Rectangle()
                        .foregroundStyle(.green)
                        .tag(2)
                    Rectangle()
                        .foregroundStyle(.red)
                        .tag(3)
                    Rectangle()
                        .foregroundStyle(.pink)
                        .tag(4)
                    Rectangle()
                        .foregroundStyle(.orange)
                        .tag(5)
                }
                .frame()
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .onReceive(timer) { value in  // value that gets published by publisher -> based on type (Timer publish date) -> every second
            // here we subscribe to publisher
            // Show current time
//            currentDate = value
            
            // Count down
//            if count <= 1 {
//                finishedText = "Finished!"
//            } else {
//                count -= 1
//            }
            
            // How much time is remaining
//            updateTimeRemaining()
            
            // ANimation Counter
            
//            withAnimation(.easeInOut(duration: 0.5)){
//                count = count == 3 ? 0 : count + 1
//            }
//            
            withAnimation(.default){
                count = count == 5 ? 0 : count + 1
            }
            
//            if count == 3 {
//                count = 0
//            } else {
//                count += 1
//            }
        }
    }
}

#Preview {
    TimerBootcamp()
}

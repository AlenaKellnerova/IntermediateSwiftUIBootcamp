//
//  BackgroundThreadBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 10.04.2025.
//

import SwiftUI


class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Is Main Thread: \(Thread.isMainThread)")
            print("Current Thread: \(Thread.current)")
//            Thread.isMainThread
//            Thread.current
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Is Main Thread: \(Thread.isMainThread)")
                print("Current Thread: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}

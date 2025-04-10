//
//  WeakSelfBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 10.04.2025.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(10)
        }
    }
}


class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Init")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("Deinit")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
//        DispatchQueue.global().async {
//            self.data = "New Data!!!" // = creating a STRONG refernce to class
//        }
        
        // Until 500 -> class will not deinitialize
        // Not efficient to keep class alive
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
//            self.data = "New Data!!!"
//        }
        
        // Use WEAK reference
        // For longer task -> so that screen is not kept alive
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!!!"
        }
        
    }

}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second Screen")
                .font(.headline)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

#Preview {
    WeakSelfBootcamp()
}

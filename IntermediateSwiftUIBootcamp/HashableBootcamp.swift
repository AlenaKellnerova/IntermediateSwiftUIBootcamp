//
//  HashableBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI

// Option 1: Identifiable
//struct MyCustomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}

// Option 2: Hashable
struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
//    let data: [String] = ["ONE", "TWO", "THREE", "FOUR", "FIVE"]  // String confroms to Hashable
    let data: [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four"),
        MyCustomModel(title: "Five"),
        MyCustomModel(title: "Six"),
        MyCustomModel(title: "Seven"),
        MyCustomModel(title: "Eight"),
        MyCustomModel(title: "Nine"),
        MyCustomModel(title: "Ten"),
        MyCustomModel(title: "Eleven")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Identifiable
//                ForEach(data) { item in
//                    Text(item.title)
//                }
                // Hashable
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}

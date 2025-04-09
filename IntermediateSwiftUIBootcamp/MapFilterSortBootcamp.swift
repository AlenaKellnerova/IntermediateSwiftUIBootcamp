//
//  MapFilterSortBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class MapFilterSortBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var sortedDataArray: [UserModel] = []
    @Published var filteredDataArray: [UserModel] = []
    @Published var mappedDataArray: [String] = []
    @Published var compactMapDataArray: [String] = []
    @Published var complexMappedDataArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // SORT (BY POINTS)
        
//        sortedDataArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
        sortedDataArray = dataArray.sorted(by: { $0.points > $1.points })
        
        // FILTER (is verified)
//        filteredDataArray = dataArray.filter({ user in
//            return user.isVerified
//        })
//        
        filteredDataArray = dataArray.filter({ $0.isVerified })
        
        // MAP (array of user names)
//        mappedDataArray = dataArray.map({ user in
//            return user.name
//        })
        
        mappedDataArray = dataArray.map({ $0.name ?? "Error" })
        
        // COMPACT MAP - for OPTIONAL values
//        compactMapDataArray = dataArray.compactMap({ user in
//            user.name
//        })
        
        compactMapDataArray = dataArray.compactMap({ $0.name })
        
        // COMPLEX FILTERING
//        let sort = dataArray.sorted(by: { $0.points > $1.points })
//        let filter = dataArray.filter({ $0.isVerified })
//        let map = dataArray.compactMap({ $0.name })
        
        compactMapDataArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "John Doe", points: 3, isVerified: true)
        let user2 = UserModel(name: "Alena", points: 5, isVerified: false)
        let user3 = UserModel(name: nil, points: 0, isVerified: true)
        let user4 = UserModel(name: nil, points: 10, isVerified: true)
        let user5 = UserModel(name: "Jane", points: 13, isVerified: false)
        let user6 = UserModel(name: "Don", points: 29, isVerified: true)
        let user7 = UserModel(name: "Deede", points: 3, isVerified: true)
        let user8 = UserModel(name: "Summer", points: 1, isVerified: true)
        let user9 = UserModel(name: "Autumn", points: 9, isVerified: true)
        let user10 = UserModel(name: "JT", points: 14, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
}

struct MapFilterSortBootcamp: View {
    
    @StateObject var vm = MapFilterSortBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.compactMapDataArray, id: \.self) { name in
                    Text(name)
                }
//                ForEach(vm.filteredDataArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .foregroundStyle(.green)
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    MapFilterSortBootcamp()
}

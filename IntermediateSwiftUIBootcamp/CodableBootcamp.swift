//
//  CodableBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.04.2025.
//

import SwiftUI


struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // DECODER
    enum CodingKeys: String, CodingKey { // needs to be used when using decoder.container
        case id
        case name
        case points
        case isPremium = "is_premium"
    }
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decodeIfPresent(String.self, forKey: .id)) ?? (try? container.decodeIfPresent(Int.self, forKey: .id).map { String($0) }) ?? "0"
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        self.points = try container.decodeIfPresent(Int.self, forKey: .points) ?? 0
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium) ?? false
    }
    
    // ENCODER -> To convert CustomerModel and convert to JSON Data
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let data = getJsonData() else { return } // data = as it comes from the internet
        print("JSON Data")
        print(data)
        let jsonString = String(data: data, encoding: .utf8)
        print("JSON String")
        print(jsonString)
        
        // Manual Parsing
//        if let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//           let dictionary = localData as? [String: Any],
//           let id = dictionary["id"] as? String,
//           let name = dictionary["name"] as? String,
//           let points = dictionary["points"] as? Int,
//           let isPremium = dictionary["isPremium"] as? Bool
//        {
//            self.customer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//        }
        
        // JSON Decoder
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
        }
    }
    
    func getJsonData() -> Data? {
        
        // Using ENCODE
//        let customer = CustomerModel(id: "11", name: "John Doe", points: 777, isPremium: true)
//        let jsonData = try? JSONEncoder().encode(customer)
        
        // Manually
        let dictionary: [String: Any?] = [
            "id" : 1,
            "name" : "Alena",
            "points" : 1000,
            "is_premium" : true
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text("Id: \(customer.id)")
                Text("Name: \(customer.name)")
                Text("Points: \(customer.points)")
                Text("Premium: \(customer.isPremium ? "Yes" : "No")")
            } else {
                Text("Loading...")
            }
        }
    }
}

#Preview {
    CodableBootcamp()
}

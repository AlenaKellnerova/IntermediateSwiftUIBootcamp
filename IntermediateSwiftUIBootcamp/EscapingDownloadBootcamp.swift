//
//  EscapingDownloadBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 30.04.2025.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class EscapingDownloadViewModel: ObservableObject {
    

    @Published var posts: [PostModel] = []
    
    init () {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        downloadData(from: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned")
            }
        }
    }
    
    func downloadData(from url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data: ")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }
        .resume()
    }
    
}

struct EscapingDownloadBootcamp: View {
    
    @StateObject var vm = EscapingDownloadViewModel()
    
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
    }
}

#Preview {
    EscapingDownloadBootcamp()
}

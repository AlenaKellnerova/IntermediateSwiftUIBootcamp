//
//  CombineDownload.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 30.04.2025.
//

import SwiftUI
import Combine

class CombineDownloadViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init () {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        /*
         1. Sign Up: for subscription
         2. Make the package: behind the scenes
         3. Receive: the package at the front door
         4. Check the box: if it itsnt damaged = try map
         5. Open the box: and make sure item is correct = decode
         6. Use the item: !!! = sink
         7. Cancell: at any time = store
         */
        URLSession.shared.dataTaskPublisher(for: url) // gous on the background thread
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main) // self.posts = run on main thread = no warning
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
//            .replaceError(with: []) can be used instead of switch
            .sink { completion in
                print("Completion: \(completion)")
                switch completion {
                case .finished:
                    print("finished!")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables) // has to be cancellable

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct CombineDownload: View {
    
    @StateObject var vm = CombineDownloadViewModel()
    
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
    CombineDownload()
}

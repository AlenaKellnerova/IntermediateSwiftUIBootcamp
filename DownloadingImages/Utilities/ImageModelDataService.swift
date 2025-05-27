//
//  ImageModelDataService.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.05.2025.
//

import Foundation
import Combine

class ImageModelDataService {
    
    static let instance = ImageModelDataService()
    @Published var imageModels: [ImageModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [ImageModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error)")
                }
            } receiveValue: { [weak self] returnedImageModels in
                self?.imageModels = returnedImageModels
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}

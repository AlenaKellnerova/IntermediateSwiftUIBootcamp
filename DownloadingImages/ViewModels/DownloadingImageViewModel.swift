//
//  DownloadingImageViewModel.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 26.05.2025.
//

import Foundation
import SwiftUI
import Combine

class DownloadingImageViewModel: ObservableObject {
    
//    let cacheManager = ImageModelCacheManager.instance
    let fileManager = ImageModelFileManager.instance
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    var cancellables = Set<AnyCancellable>()
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImageFromStorageOrDownload()
    }
    
    // 1. Try to get image from cache -> or download
    // 2. Try to get image from file manager -> or download
    func getImageFromStorageOrDownload() {
        
        // 1.
//        if let cachedImage = cacheManager.getImageFromCache(key: imageKey) {
//            image = cachedImage
//            print("Getting image from cache...")
//            isLoading = false
//        } else {
//            downloadImage()
//        }
        
        // 2.
        if let storedImage = fileManager.getImageFromFileManager(key: imageKey) {
            image = storedImage
            print("Getting image from file manager...")
            isLoading = false
        } else {
            downloadImage()
        }
    }
    
  
    
    func downloadImage() {
        print("Downloading images now...")
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) } // Transforms raw data from the network into UIImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                // what is this
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard let self = self, let image = image else { return }
                self.image = image
//                self.cacheManager.addImageToCache(key: imageKey, value: image)  -> store in Cache
                self.fileManager.saveImageToFileManager(key: imageKey, value: image)
                
            }
            .store(in: &cancellables)

    }
    
    
}

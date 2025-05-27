//
//  NSCacheBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.05.2025.
//

import SwiftUI

// Local storage - temporary location
// Important - while using app = current session, Not important long term


class CacheManager {
    
    static let instance = CacheManager()
    private init() { }
    
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Number of objects cache can hold
        cache.totalCostLimit =  1024 * 1024 * 100  // Data 100mb => when exceeding cache will remove old items and replace with new ones
        return cache
    }()
    
    func addImageToCache(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Image added to cache: \(name)")
    }
    
    func removeImageFromCache(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from cache: \(name)")
    }
    
    func getImageFromCache(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    private let imageName: String = "light_background"
    let cacheManager = CacheManager.instance
    
    
    init () {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        cacheManager.addImageToCache(image: image, name: imageName)
    }
    
    func removeFromCache() {
        cacheManager.removeImageFromCache(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnedImage = cacheManager.getImageFromCache(name: imageName) {
            cachedImage = returnedImage
            print("Image retrieved from cache successfully!")
        } else {
            print("Error retrieving image from cache.")
        }
    }
    
}

struct NSCacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                }
                
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get Image from Cache")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                }
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                }


                Spacer()
                
                
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    NSCacheBootcamp()
}

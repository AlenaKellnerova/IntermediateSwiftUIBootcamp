//
//  FileManagerBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 21.05.2025.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder!")
            } catch {
                print("Error creating folder: \(error.localizedDescription)")
            }
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        // UIImage cant be saved but Data for Image
        guard let data = image.jpegData(compressionQuality: 1.0), // 100% quality
              let path = getPathForImage(name: name)
        else {
            print("Error getting data")
            return "Error getting data."
        }
        
        // Documets/ Data - user-generated/ cannot be recreated by Application should be stored in /Documents => will be automatically backed up by iCloud
//        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Data that can be regenerated/ downloaded again should be stored in /Library/Caches directory = Downloadable Content
//        let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        // Data that is used temporarily should be stored in /tmp folder -> not backed up by iClodu, should be deleted
//        let directory3 = FileManager.default.temporaryDirectory
        
//        print(directory)
//        print(directory2)
//        print(directory3)
        
//        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first // for it returns an array
//        let path = directory?.appendingPathComponent("\(name).jpg")
        
//        print(directory)
//        print(path)
        
        
        do {
            try data.write(to: path)
            print("Success savingto path: \(path)")
            return "Succes saving!"
        } catch {
            print("Error saving file: \(error.localizedDescription)")
            return "Error saving image."
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            print("Error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
        
        
    }
    
    func deleteImage(name: String) -> String {
        
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting path")
            return "Error getting path."
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Image deleted successfully!")
            return "Image deleted!"
        } catch {
            print("Error deleting image: \(error.localizedDescription)")
            return "Error deleting image!"
        }
    }
    
    func deleteFolder() {
        
        // Path just for the folder name
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
                return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder!")
        } catch {
            print("Error deleting folder: \(error.localizedDescription)")
        }
        
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil
        }
        return path
    }
    
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "light_background"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromeDocumentDirectory()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromeDocumentDirectory() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to File Manager")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from File Manager")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}

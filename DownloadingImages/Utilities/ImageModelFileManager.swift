//
//  ImageModelFileManager.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 27.05.2025.
//

import Foundation
import SwiftUI

class ImageModelFileManager {
    
    static let instance = ImageModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("New folder created at: \(url.path)")
            } catch {
                print("Error creating folder. Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // .../downloaded_photos
    // .../downloaded_photos/123.png
    private func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else { return nil }
        return folderPath.appendingPathComponent(key + ".png")
    }
    
    func saveImageToFileManager(key: String, value: UIImage) {
        guard
            let imagePath = getImagePath(key: key),
              let data = value.pngData() else { return }
        do {
            try data.write(to: imagePath)
            print("Image saved to file manager successfully.")
        } catch {
            print("Error saving image to file manager. Error: \(error.localizedDescription)")
        }
    }
    
    func getImageFromFileManager(key: String) -> UIImage? {
        guard
            let imagePath = getImagePath(key: key),
            FileManager
                .default
                .fileExists(atPath: imagePath.path) else { return nil }
        return UIImage(contentsOfFile: imagePath.path)
    }
    
    
    
}

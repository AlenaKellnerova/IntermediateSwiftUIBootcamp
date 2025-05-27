//
//  ImageModel.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.05.2025.
//

import Foundation

struct ImageModel: Identifiable, Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
}

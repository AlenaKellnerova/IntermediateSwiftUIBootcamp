//
//  DownloadingImagesRow.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 26.05.2025.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let imageModel: ImageModel
    
    var body: some View {
        HStack {
//            Circle()
//            DownloadingImageView(imageUrl: imageModel.url)
            DownloadingImageView(imageUrl: "https://fastly.picsum.photos/id/486/200/300.jpg?hmac=yDvKMocLz1Sxg1XI9BgCJRlIyKqiBTdI9RZDij_z8xM", imageId: "\(imageModel.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(imageModel.title)
                    .font(.headline)
                
                Text(imageModel.url)
                    .italic()
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadingImagesRow(imageModel: ImageModel(id: 1, albumId: 1, title: "Title", url: "url", thumbnailUrl: "thumbnail"))
        .padding()
        .previewLayout(.sizeThatFits)
}

//
//  DownloadingImageView.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 26.05.2025.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var vm : DownloadingImageViewModel
    
    init(imageUrl: String, imageId: String) {
        _vm = StateObject(wrappedValue: DownloadingImageViewModel(url: imageUrl, key: imageId))
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let image = vm.image {
//                Circle()
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    DownloadingImageView(imageUrl: "", imageId: "")
//        .frame(width: 75, height: 75)
//        .previewLayout(.sizeThatFits)
}

//
//  DownloadingImagesBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.05.2025.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { imageModel in
                    DownloadingImagesRow(imageModel: imageModel)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}

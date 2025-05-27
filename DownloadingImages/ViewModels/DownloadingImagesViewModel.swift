//
//  DownloadingImagesViewModel.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 24.05.2025.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [ImageModel] = []
    let dataService = ImageModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$imageModels.sink { [weak self] returnedImageModels in
            self?.dataArray = returnedImageModels
        }
        .store(in: &cancellables)
    }
}

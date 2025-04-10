//
//  EscapingBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 10.04.2025.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        
        downloadData5 { [weak self] downloadResponse in
            self?.text = downloadResponse.data
        }

    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New Data")
    }
    
    // @escaping -> makes the code asynchronous
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New Data")
        }
    }
    
    // to make it even more readable..
    func downloadData4(completionHandler: @escaping (DownloadResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           let downloadResponse = DownloadResponse(data: "New Data")
            completionHandler(downloadResponse)
        }
    }
    
    // And even more
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           let downloadResponse = DownloadResponse(data: "New Data")
            completionHandler(downloadResponse)
        }
    }
    
    func doSomething(_ data: String) -> () {
        print(data)
    }
    
}

typealias DownloadCompletion = (DownloadResponse) -> ()

struct DownloadResponse {
    let data: String
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}

//
//  TypealiasBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 10.04.2025.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel


struct TypealiasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "Titanic", director: "James Cameron", count: 10)
    @State var tvItem: TVModel = TVModel(title: "Game of Thrones", director: "David Benioff", count: 10)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}

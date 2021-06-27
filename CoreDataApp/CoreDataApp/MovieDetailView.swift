//
//  MovieDetailView.swift
//  CoreDataApp
//
//  Created by Pawan Kumar on 27/06/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    let coreDataDM: CoreDataManager
    @State private var  movieName: String = ""
    @Binding  var needRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                if !self.movieName.isEmpty {
                    movie.title = movieName
                    coreDataDM.updateMovie()
                    needRefresh.toggle()
                }
            }
        }.padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataManager = CoreDataManager()
        let movie = Movie(context: CoreDataManager().persistentContainer.viewContext)
        MovieDetailView(movie: movie,coreDataDM: coreDataManager,needRefresh: .constant(false))
    }
}

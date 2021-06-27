//
//  ContentView.swift
//  CoreDataApp
//
//  Created by Pawan Kumar on 20/06/21.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    
    @State private var movieName: String = ""
    @State private var movies: [Movie] = []
    
    @State private var needRefresh: Bool = false
    private func getAllMovies() {
        movies = coreDM.getAllMovie()
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(action)
        UIApplication.shared.windows.first?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Movie Name", text: $movieName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    if !self.movieName.isEmpty {
                        if let _ = self.movies.filter({($0.title ?? "") == self.movieName.trimmingCharacters(in: .whitespaces)}).first {
                            self.showAlert(message: "Movie name already exist.")
                        } else {
                            coreDM.saveMovie(title: movieName)
                            getAllMovies()
                        }
                    } else {
                       let message =  "Please enter Movie Name"
                        self.showAlert(message: message)
                    }
                    
                 
                }
                List {
                    ForEach(movies, id: \.self) { movie in
                       NavigationLink(
                        destination: MovieDetailView(movie: movie,coreDataDM: coreDM,needRefresh: $needRefresh),
                        label: {
                            Text("\(movie.title ?? "")")
                        })
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie: movie)
                            getAllMovies()
                        }
                    })
                }.listStyle(PlainListStyle())
                .accentColor(needRefresh ? .white : .red)
            }.padding()
            .onAppear(perform: {
                getAllMovies()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

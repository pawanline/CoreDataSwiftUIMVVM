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
    
    var body: some View {
        VStack {
            TextField("Movie Name", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                coreDM.saveMovie(title: movieName)
            }
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

//
//  CoreDataManger.swift
//  CoreDataApp
//
//  Created by Pawan Kumar on 20/06/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func saveMovie(title: String)  {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        do {
            try persistentContainer.viewContext.save()
            print("Moview Saved")
        } catch {
            print("Failed to save moview \(error.localizedDescription)")
        }
    }
    
    func getAllMovie() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
           return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func updateMovie() {
        do {
             try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Some error occured: \(error.localizedDescription)")
        }
    }
    
    func deleteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
}


//
//  CoreDataAppApp.swift
//  CoreDataApp
//
//  Created by Pawan Kumar on 20/06/21.
//

import SwiftUI

@main
struct CoreDataAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}

//
//  ViticomMallApp.swift
//  ViticomMall
//
//  Created by Victor Tejeda on 20/7/25.
//

import SwiftUI
import CoreData

@main
struct ViticomMallApp: App {
    // Configuración del stack de Core Data
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ViticomMall")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

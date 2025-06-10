//
//  CoreDataContextConfig.swift
//  App-Challenge
//
//  Created by Gustavo Ferreira bassani on 09/06/25.
//

import CoreData

class PersistenceController {
    //create a singleton constant.
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer

    init() {
        // pass the name of the .xcdatamodel file as a parameter
        container = NSPersistentCloudKitContainer(name: "CloudKitTest")

        // Configure the container to use CloudKit
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No persistent store description found.")
        }
        // This option should already be set if you enabled CloudKit in Xcode, but double-check:
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        // pass the actual container identifier as a parameter
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.containerTest.app")
        // error handling
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// This configuration allows the context to synchronize with the user's private CloudKit database.
// To use this singleton, access it via: PersistenceController.shared.container.viewContext


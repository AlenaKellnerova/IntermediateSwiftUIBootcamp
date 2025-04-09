//
//  CoreDataRelationshipsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI
import CoreData

// 3 Entities:
/*
 BusinessEntity
 DepartmentEntity
 EmployeeEntity
 */

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading CoreData \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving core data: \(error)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let coreDataManager = CoreDataManager.instance
    
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}

//
//  DataManager.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

protocol GoalDataManagerProtocol {
    func createGoal(title: String, icon: String)
}

typealias DataManagerProtocol = GoalDataManagerProtocol

final class DataManager {
    static let shared = DataManager()
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
}

// MARK: - GoalDataManagerProtocol
extension DataManager: GoalDataManagerProtocol {
    func createGoal(title: String, icon: String) {
        let context = persistenceController.container.viewContext
        context.performAndWait {
            let goalsFR: NSFetchRequest<CNGoal> = CNGoal.fetchRequest()
            do {
                let goals = try context.fetch(goalsFR)
                for (index, goal) in goals.enumerated() {
                    goal.position = Int16(index + 1)
                }
                
                let goal = CNGoal(context: context)
                goal.id = UUID()
                goal.title = title
                goal.icon = icon
                goal.position = 0
                goal.addedOn = Date()
                goal.modifiedOn = Date()
                
                try context.save()
            } catch {
                fatalError("error \(error)")
            }
        }
    }
    
    
}

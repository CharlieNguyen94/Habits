//
//  DataManager+Goal.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

protocol GoalDataManagerProtocol {
    func createGoal(title: String, icon: String)
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
    
    func readGoal(id: UUID?) -> CNGoal? {
        guard let id = id else { return nil }
        let context = persistenceController.container.viewContext
        var goal: CNGoal?
        context.performAndWait {
            let request: NSFetchRequest<CNGoal> = CNGoal.fetchRequest()
            var predicates: [NSPredicate] = []
            if let predicate = request.predicate {
                predicates.append(predicate)
            }
            predicates.append(NSPredicate(format: "id = %@", argumentArray: [id]))
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.fetchLimit = 1
            do {
                goal = try context.fetch(request).first
            } catch {
                fatalError("error \(error)")
            }
        }
        return goal
    }
}

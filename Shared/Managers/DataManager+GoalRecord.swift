//
//  DataManager+GoalRecord.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

protocol GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID?, date: Date)
    func readGoalRecord(for goalID: UUID?, date: Date) -> CNGoalRecord?
    func deleteGoalRecord(for goalID: UUID?, date: Date)
}

extension GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID?, date: Date = Date()) {
        createGoalRecord(for: goalID, date: date)
    }
    
    func readGoalRecord(for goalID: UUID?, date: Date = Date()) -> CNGoalRecord? {
        readGoalRecord(for: goalID, date: date)
    }
    
    func deleteGoalRecord(for goalID: UUID?, date: Date = Date()) {
        deleteGoalRecord(for: goalID, date: date)
    }
}

// MARK: - GoalRecordDataManagerProtocol
extension DataManager: GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID?, date: Date) {
        let context = persistenceController.container.viewContext
        context.performAndWait {
            do {
                guard let goal = readGoal(id: goalID) else { return }
                let record = CNGoalRecord(context: context)
                record.date = date
                record.goal = goal
                try context.save()
            } catch {
                fatalError("error \(error)")
            }
        }
    }
    
    func readGoalRecord(for goalID: UUID?, date: Date) -> CNGoalRecord? {
        guard let goalID = goalID else { return nil }
        let context = persistenceController.container.viewContext
        var goalRecord: CNGoalRecord?
        context.performAndWait {
            let request: NSFetchRequest<CNGoalRecord> = CNGoalRecord.fetchRequest()
            let calendar = Calendar.current
            let fromDate = calendar.startOfDay(for: date)
            let toDate = calendar.date(byAdding: .day, value: 1, to: fromDate)!
            request.predicate = NSPredicate(format: "goal.id = %@ AND date >= %@ AND date < %@", argumentArray: [goalID, fromDate, toDate])
            request.fetchLimit = 1
            do {
                goalRecord = try context.fetch(request).first
            } catch {
                fatalError("error \(error)")
            }
        }
        return goalRecord
    }
    
    func deleteGoalRecord(for goalID: UUID?, date: Date) {
        let context = persistenceController.container.viewContext
        context.performAndWait {
            do {
                guard let goalRecord = readGoalRecord(for: goalID, date: date) else { return }
                context.delete(goalRecord)
                try context.save()
            } catch {
                fatalError("error \(error)")
            }
        }
    }
}

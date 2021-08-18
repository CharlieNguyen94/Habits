//
//  CNGoal.swift
//  Habits (iOS)
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

@objc(CNGoal)

final class CNGoal: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var icon: String
    @NSManaged public var title: String
    @NSManaged public var position: Int16
    @NSManaged public var addedOn: Date
    @NSManaged public var modifiedOn: Date
    @NSManaged public var isRemoved: Bool
    @NSManaged public var records: Set<CNGoalRecord>?
}

extension CNGoal {
    class func fetchRequest() -> NSFetchRequest<CNGoal> {
        let request = NSFetchRequest<CNGoal>(entityName: "CNGoal")
        request.predicate = NSPredicate(format: "isRemoved == false")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CNGoal.position, ascending: true)]
        return request
    }
}

// MARK: - Identifiable
extension CNGoal: Identifiable {}

extension CNGoal {
    var lastRecord: CNGoalRecord? {
        records?.sorted { $0.date > $1.date }.first
    }
    
    var isCompletedToday: Bool {
        guard let lastRecord = lastRecord else { return false }
        return Calendar.current.isDateInToday(lastRecord.date)
    }
}

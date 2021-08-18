//
//  CNGoalRecord.swift
//  Habits (iOS)
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

@objc(CNGoalRecord)
final class CNGoalRecord: NSManagedObject {
    @NSManaged public var date: Date
    @NSManaged public var goal: CNGoal?
}

extension CNGoalRecord {
    class func fetchRequest() -> NSFetchRequest<CNGoalRecord> {
        NSFetchRequest<CNGoalRecord>(entityName: "CNGoalRecord")
    }
}

// MARK: - Identifiable
extension CNGoalRecord: Identifiable {}

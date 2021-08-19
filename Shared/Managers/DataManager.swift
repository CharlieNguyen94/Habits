//
//  DataManager.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation
import CoreData

typealias DataManagerProtocol = GoalDataManagerProtocol & GoalRecordDataManagerProtocol

final class DataManager {
    static let shared = DataManager()
    
    let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
}


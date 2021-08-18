//
//  MyGoalsViewModel.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation

final class MyGoalsViewModel: ObservableObject {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func markAsDone(_ goal: CNGoal) {
        guard !goal.isCompletedToday else { return }
        dataManager.createGoalRecord(for: goal.id)
    }
    
    func unmarkAsDone(_ goal: CNGoal) {
        dataManager.deleteGoalRecord(for: goal.id)
    }
}

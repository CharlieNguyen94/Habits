//
//  AddNewGoalViewModel.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import Foundation

final class AddNewGoalViewModel: ObservableObject {
    @Published var title = ""
    @Published var icon: String?
    
    let icons: [String] = GoalIcon.all
    
    func save() {
        fatalError("To be implemented")
    }
}

//
//  MyGoalsItemView.swift
//  Habits
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import SwiftUI

struct MyGoalsItemView: View {
    @ObservedObject var goal: CNGoal
    
    var body: some View {
        VStack {
            Text(goal.icon)
                .font(.system(size: 60))
            Text(goal.title)
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fill)
        .padding()
        .background(goal.isCompletedToday ? Color.cnCompleted : Color.cnBackground)
        .cornerRadius(8.0)
        .shadow(color: .gray, radius: 3.0, x: 0.0, y: 0.0)
    }
}

struct MyGoalsItemView_Previews: PreviewProvider {
    static var goal: CNGoal {
        let goal = CNGoal(context: PersistenceController.preview.container.viewContext)
        goal.id = UUID()
        goal.icon = "🍩"
        goal.title = "Avoid Sugar"
        goal.position = 0
        goal.addedOn = Date()
        goal.modifiedOn = Date()
        goal.isRemoved = false
        return goal
    }
    
    static var comepletedGoal: CNGoal {
        let context = PersistenceController.preview.container.viewContext
        let goalRecord = CNGoalRecord(context: context)
        goalRecord.date = Date()
        let goal = CNGoal(context: context)
        goal.id = UUID()
        goal.icon = "🏃‍♂️"
        goal.title = "Jogging"
        goal.position = 0
        goal.addedOn = Date()
        goal.modifiedOn = Date()
        goal.isRemoved = false
        goal.records = [goalRecord]
        return goal
    }
    static var previews: some View {
        Group {
            MyGoalsItemView(goal: goal)
            MyGoalsItemView(goal: comepletedGoal)
        }
        .previewLayout(.fixed(width: 160, height: 160))
    }
}

//
//  ContentView.swift
//  Shared
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(fetchRequest: CNGoal.fetchRequest(), animation: .default)
    private var goals: FetchedResults<CNGoal>


    var body: some View {
        List {
            ForEach(goals) { goal in
                HStack {
                    Text(goal.icon)
                    Text(goal.title)
                    Spacer()
                }
            }
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  ContentView.swift
//  Shared
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import SwiftUI
import CoreData

struct MyGoalsView: View {
    @Environment(\.managedObjectContext) private var context
    
    @StateObject var viewModel = MyGoalsViewModel()
    
    
    @FetchRequest(fetchRequest: CNGoal.fetchRequest(), animation: .default)
    private var goals: FetchedResults<CNGoal>
    
    @State private var showingAddNew = false
    
    private var columns: [GridItem] { [GridItem(.adaptive(minimum: 100, maximum: 160), spacing: 10.0)] }
    
    
    var body: some View {
        NavigationView {
            Group {
                if goals.isEmpty {
                    Text("No goals yet! 😔")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10.0) {
                            ForEach(goals) { goal in
                                Button {
                                    viewModel.markAsDone(goal)
                                } label: {
                                    MyGoalsItemView(goal: goal)
                                }
                                .contextMenu {
                                    contextMenuItems(for: goal)
                                }
                            }
                        }
                        .padding(10)
                    }
                }
            }
            .navigationTitle("Goals")
            .navigationBarItems(trailing: addNewButton)
        }
        .sheet(isPresented: $showingAddNew) {
            AddNewGoalView()
        }
    }
    
    @ViewBuilder
    private func contextMenuItems(for goal: CNGoal) -> some View {
        if goal.isCompletedToday {
            Button {
                viewModel.unmarkAsDone(goal)
            } label: {
                Label("Not completed", systemImage: "arrow.uturn.backward")
            }
        }
        Button {
            // Nothing for now
        } label: {
            Label("Edit", systemImage: "pencil")
        }
        Divider()
        Button {
            // Nothing for now
        } label: {
            Label("Delete", systemImage: "trash")
    }
}
    
    private var addNewButton: some View {
        Button(action: {
            showingAddNew = true
        }, label: {
            Text("New Goal")
        })
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var dataManager: DataManagerProtocol {
        DataManager(persistenceController: .preview)
    }
    static var previews: some View {
        MyGoalsView(viewModel: MyGoalsViewModel(dataManager: dataManager))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

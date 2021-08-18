//
//  ContentView.swift
//  Shared
//
//  Created by Charlie Nguyen on 18/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {


    var body: some View {
        Text("Hello world")
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

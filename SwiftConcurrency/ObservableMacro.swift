//
//  ObservableMacro.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/1/25.
//

import SwiftUI


actor TitleDatabase {
    
    func getNewTitle() -> String {
        "Some new Title"
    }
}



class observableViewModel: ObservableObject {
    
    let database = TitleDatabase()
    @Published var title = ""
    
    func updateTitle() async {
        title = await database.getNewTitle()
    }
}



struct ObservableMacro: View {
    
    @StateObject private var viewModel = observableViewModel()
    
    var body: some View {
        
        Text(viewModel.title)
            .task {
                await viewModel.updateTitle()
            }
    }
}

#Preview {
    ObservableMacro()
}

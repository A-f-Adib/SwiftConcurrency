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



@Observable class observableViewModel {
    
    @ObservationIgnored let database = TitleDatabase()
    @MainActor var title = ""
    
    func updateTitle() async {
        
        let title = await database.getNewTitle()
        
        await MainActor.run {
            self.title = title
            print(Thread.current)
        }
    }
}



struct ObservableMacro: View {
    
    @State private var viewModel = observableViewModel()
    
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

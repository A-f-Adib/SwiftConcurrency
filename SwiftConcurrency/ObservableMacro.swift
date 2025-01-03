//
//  ObservableMacro.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/1/25.
//

import SwiftUI

class observableViewModel: ObservableObject {
    @Published var title = ""
    
    func updateTitle() {
        title = "Some new title"
    }
}

struct ObservableMacro: View {
    @StateObject private var viewModel = observableViewModel()
    
    var body: some View {
        Text(viewModel.title)
            .task {
                viewModel.updateTitle()
            }
    }
}

#Preview {
    ObservableMacro()
}

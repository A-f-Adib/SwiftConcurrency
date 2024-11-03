//
//  DoCatchTryThrows.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/11/24.
//

import SwiftUI

class DoCatchTryThrowsDataManager  {
    
    func getTitle() -> String {
        return "New Text"
    }
}


class DoCatchTryThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
        let newTitle = manager.getTitle()
        self.text = newTitle
    }
}


struct DoCatchTryThrows: View {
    
    @State private var viewModel = DoCatchTryThrowsViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrows()
}

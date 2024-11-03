//
//  DoCatchTryThrows.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/11/24.
//

import SwiftUI

class DoCatchTryThrowsDataManager  {
    
    let isActive: Bool = false
    
    func getTitle() -> String {
        return "New Text"
    }
    
    func getTitle2() throws -> String {
        if isActive {
            return "New Text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}


class DoCatchTryThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
//        let newTitle = manager.getTitle()
//        self.text = newTitle
        
        do {
            let newTitle = try manager.getTitle2()
            self.text = newTitle
        } catch {
            self.text = error.localizedDescription
        }
    }
}


struct DoCatchTryThrows: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsViewModel()
    
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

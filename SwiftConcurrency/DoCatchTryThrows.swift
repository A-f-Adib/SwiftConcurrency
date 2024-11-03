//
//  DoCatchTryThrows.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/11/24.
//

import SwiftUI

class DoCatchTryThrowsDataManager  {
    
    let isActive: Bool = true
    
    func getTitle() -> String {
        return "New Text"
    }
    
    func getTitle2() throws -> String {
//        if isActive {
//            return "Second function Text"
//        } else {
            throw URLError(.badServerResponse)
//        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "Third function Text"
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
            let secondTitle = try? manager.getTitle2()
            if let secondTitle = secondTitle {
                self.text = secondTitle
            }
            
            let thirdTitle = try manager.getTitle3()
            self.text = thirdTitle
            
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

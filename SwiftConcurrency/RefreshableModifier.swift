//
//  RefreshableModifier.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/12/24.
//

import SwiftUI


final class RefreshableDataManager {
    
    func getData() -> [String] {
        ["Apple", "Orange", "Banana"].shuffled()
    }
}


@MainActor
final class RefreshableViewModel : ObservableObject {
    
}



struct RefreshableModifier: View {
    
    @StateObject private var viewModel = RefreshableViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RefreshableModifier()
}

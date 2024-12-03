//
//  SearchableModifier.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/12/24.
//

import SwiftUI


struct Restaurant: Identifiable, Hashable {
    let id : String
    let title: String
}




final class RestaurantManager {
    
}


@MainActor
final class SearchableViewModel: ObservableObject {
    
    
}



struct SearchableModifier: View {
    
    @StateObject private var viewModel = SearchableViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchableModifier()
}

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
    let cuisine: CuisineOption
}


enum CuisineOption {
    case american, italian, japanese
}


final class RestaurantManager {
    
    func getRestaurant() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Club", cuisine: .american),
            Restaurant(id: "1", title: "Burger Club", cuisine: .american),
            Restaurant(id: "1", title: "Burger Club", cuisine: .american),
            Restaurant(id: "1", title: "Burger Club", cuisine: .american)
        ]
    }
}


@MainActor
final class SearchableViewModel: ObservableObject {
    
    @Published private(set) var allRestaurants: [Restaurant] = []
    let manager = RestaurantManager()
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getRestaurant()
        } catch {
        print(error)
        }
    }
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

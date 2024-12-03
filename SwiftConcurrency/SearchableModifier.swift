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


enum CuisineOption: String {
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
    @Published var searchText : String = ""
    
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
      
        ScrollView {
            VStack {
                ForEach(viewModel.allRestaurants) { restaurant in
                    restaurantRow(restaurant: restaurant)
                }
            }
            .padding()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search Restaurant"))
        .navigationTitle("Restaurants")
        .task {
            await viewModel.loadRestaurants()
        }
    }
    
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
       
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    SearchableModifier()
}

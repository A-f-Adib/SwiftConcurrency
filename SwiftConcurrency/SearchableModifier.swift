//
//  SearchableModifier.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/12/24.
//

import SwiftUI
import Combine


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
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    let manager = RestaurantManager()
    @Published var searchText : String = ""
    private var cancellables = Set<AnyCancellable>()
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    
    init() {
        addSubscribers()
    }
    
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterRestaurents(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    
    private func filterRestaurents(searchText: String) {
        
        guard !searchText.isEmpty else {
            filteredRestaurants = []
            return
        }
        
        let search = searchText.lowercased()
        filteredRestaurants = allRestaurants.filter( { restaurant in
            let titleContainSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            return titleContainSearch || cuisineContainSearch
        })
    }
    
    
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
                ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants) { restaurant in
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

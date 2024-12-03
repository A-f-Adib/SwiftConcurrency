//
//  RefreshableModifier.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/12/24.
//

import SwiftUI


final class RefreshableDataManager {
    
    func getData() async throws -> [String] {
        ["Apple", "Orange", "Banana"].shuffled()
    }
}


@MainActor
final class RefreshableViewModel : ObservableObject {
    
    @Published private(set) var items: [String] = []
    let manager = RefreshableDataManager()
    
    func loadData() {
        Task {
            do {
                items = try await manager.getData()
            } catch {
                print(error)
            }
        }
    }
}



struct RefreshableModifier: View {
    
    @StateObject private var viewModel = RefreshableViewModel()
    
    var body: some View {
       
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                            Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                viewModel.loadData()
            }
            .navigationTitle("Refreshable Modifier")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    RefreshableModifier()
}

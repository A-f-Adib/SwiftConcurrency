//
//  GlobalActors.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 12/11/24.
//

import SwiftUI

@globalActor struct firstGlobalActor {
    static var shared = NewDataManager()
}

actor NewDataManager {
    func getDataFromDatabase() -> [String] {
        return ["one", "two", "three", "four", "five"]
    }
}


class GlobalActorViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    let manager = firstGlobalActor.shared
    
    @firstGlobalActor
    func getData() {
        
        Task {
            let data = await manager.getDataFromDatabase()
            self.dataArray = data
        }
    }
}

struct GlobalActors: View {
    
    @StateObject private var viewModel = GlobalActorViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActors()
}

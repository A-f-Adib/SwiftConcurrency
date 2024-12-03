//
//  AsyncMvvm.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/12/24.
//

import SwiftUI


final class ManagerClass {
    
    func getData() async throws -> String  {
        "Some Data"
    }
}



actor ManagerActor {
    
    func getData() async throws -> String  {
        "Some Data"
    }
}


@MainActor
final class AsyncMvViewModel: ObservableObject {
    
    let managerClass = ManagerClass()
    let managerActor = ManagerActor()
    
    @Published private(set) var myData: String = "Starting text"
    private var tasks: [Task<Void, Never>] = []
    
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
    
    
    func onClickButton() {
        
        let task = Task {
            do {
//                myData = try await managerClass.getData()
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
}



struct AsyncMvvm: View {
    
    @StateObject private var viewModel = AsyncMvViewModel()
    
    var body: some View {
        VStack {
            Button("Click") {
                viewModel.onClickButton()
            }
            
            Button(viewModel.myData) {
                viewModel.onClickButton()
            }
        }
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
}

#Preview {
    AsyncMvvm()
}

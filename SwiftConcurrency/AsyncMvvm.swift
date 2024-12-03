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



final class AsyncMvViewModel: ObservableObject {
    
    let managerClass = ManagerClass()
    let managerActor = ManagerActor()
    
    func onClickButton() {
        Task {
            
        }
    }
    
}



struct AsyncMvvm: View {
    
    @StateObject private var viewModel = AsyncMvViewModel()
    
    var body: some View {
        Button("Click") {
            viewModel.onClickButton()
        }
    }
}

#Preview {
    AsyncMvvm()
}

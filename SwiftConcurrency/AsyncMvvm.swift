//
//  AsyncMvvm.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 3/12/24.
//

import SwiftUI

final class ManagerClass {
    
}

actor ManagerActor {
    
}

final class AsyncMvViewModel: ObservableObject {
    
    let managerClass = ManagerClass()
    let managerActor = ManagerActor()
    
}

struct AsyncMvvm: View {
    
    @StateObject private var viewModel = AsyncMvViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AsyncMvvm()
}

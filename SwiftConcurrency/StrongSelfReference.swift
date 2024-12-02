//
//  StrongSelfReference.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 2/12/24.
//

import SwiftUI


final class StrongSelfReferenceDataManager {
    
    func getData() async -> String {
        "Update data"
    }
}



final class StrongSelfReferenceViewModel: ObservableObject {
    
    @Published var data : String = "Some title"
    let dataManager = StrongSelfReferenceDataManager()
    
    
    //Implies Strong reference
    func UpdateData() {
        Task {
            data = await dataManager.getData()
        }
    }
    
    //Implies Stong reference
    func UpdateData2(data: String) {
        Task {
            self.data = await dataManager.getData()
        }
    }
    
    //Implies strong refence
    func UpdateData3() {
        Task { [self] in
            self.data = await dataManager.getData()
        }
    }
    
}



struct StrongSelfReference: View {
    
    @StateObject private var viewModel = StrongSelfReferenceViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear {
                viewModel.UpdateData()
            }
    }
}

#Preview {
    StrongSelfReference()
}

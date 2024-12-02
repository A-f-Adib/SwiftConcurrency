//
//  StrongSelfReference.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 2/12/24.
//

import SwiftUI

final class StrongSelfReferenceViewModel: ObservableObject {
    
    @Published var data : String = "Some title"
}

struct StrongSelfReference: View {
    
    @StateObject private var viewModel = StrongSelfReferenceViewModel()
    
    var body: some View {
        Text(viewModel.data)
    }
}

#Preview {
    StrongSelfReference()
}

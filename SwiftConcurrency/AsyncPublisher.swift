//
//  AsyncPublisher.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 29/11/24.
//

import SwiftUI

actor AsyncPublisherDataManager {
    
    @Published var myData : [String] = []
}

class AsyncPublisherViewModel : ObservableObject {
    
    @Published var dataArray: [String] = []
    
}

struct AsyncPublisher: View {
    
    @StateObject private var viewModel = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    AsyncPublisher()
}

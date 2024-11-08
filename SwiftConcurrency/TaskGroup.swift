//
//  TaskGroup.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 9/11/24.
//

import SwiftUI


class TaskGroupViewModel: ObservableObject {
    
    @Published var images : [NSImage] = []
    
}


struct TaskGroup: View {
    
    @StateObject private var viewModel = TaskGroupViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
        }
    }
}

#Preview {
    TaskGroup()
}

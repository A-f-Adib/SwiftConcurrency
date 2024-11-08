//
//  TaskGroup.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 9/11/24.
//

import SwiftUI

class TaskGroupDataManager {
    
    func fetchImage(urlString: String) async throws -> NSImage {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
          
            let (data, _ ) = try await URLSession.shared.data(from: url)
            if let image = NSImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
            
        } catch  {
            throw error
        }
    }
}


class TaskGroupViewModel: ObservableObject {
    
    @Published var images : [NSImage] = []
    let manager = TaskGroupDataManager()
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

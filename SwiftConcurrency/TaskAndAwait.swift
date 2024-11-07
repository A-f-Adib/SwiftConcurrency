//
//  TaskAndAwait.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 8/11/24.
//

import SwiftUI

class TaskViewModel : ObservableObject {
    @Published var image : NSImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _ ) = try await URLSession.shared.data(from: url)
            self.image = NSImage(data: data)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct TaskAndAwait: View {
    @StateObject private var viewModel = TaskViewModel()
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
            
            //Task priority
            Task(priority: .high) {
                print("High: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .userInitiated) {
                print("UserInitiated: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .medium) {
                print("Medium: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .low) {
                print("Low: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .utility) {
                print("Utility: \(Thread.current) : \(Task.currentPriority)")
            }
            Task(priority: .background) {
                print("Background: \(Thread.current) : \(Task.currentPriority)")
            }
        }
    }
}

#Preview {
    TaskAndAwait()
}

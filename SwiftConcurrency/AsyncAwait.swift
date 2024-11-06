//
//  AsyncAwait.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/11/24.
//

import SwiftUI

class AsyncAwaitViewModel : ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title-1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title-2 : \(Thread.current)"
            
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title2 = "Title-3: \(Thread.current)"
                self.dataArray.append(title2)
            }
        }
    }
    
    
    func addAuthor() async {
        
        let author1 = "Author-1 : \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
            
        let author2 = "Author-2 : \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(author2)
            
            let author3 = "Author-3: \(Thread.current)"
            self.dataArray.append(author3)
        }
       
    }
    
}


struct AsyncAwait: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                    Text(data)
            }
        }
        .onAppear{
            Task {
                await viewModel.addAuthor()
                
                viewModel.addTitle1()
                viewModel.addTitle2()

            }
           
        }
    }
}

#Preview {
    AsyncAwait()
}
